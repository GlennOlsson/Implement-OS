#include "page_table.h"
#include "memory_manager.h"
#include "vga_api.h"
#include "lib.h"

extern void ASM_set_cr3(void*);

extern uint64_t p4_table;
extern uint64_t p3_table;
extern uint64_t p2_table;

#define nullptr 0

// Start of virtual address space. The variable keeps track of the next address to give out
uint64_t next_add = 0x40000000;

uint64_t count_allocated_addresses = 0;

uint16_t curr_pt_index = 0;
uint16_t curr_pml1_index = 0;
uint16_t curr_pml2_index = 0;
uint16_t curr_pml3_index = 0;
uint16_t curr_pml4_index = 0;

uint64_t* physical_pf;

typedef uint64_t PML;

void modify_bit(uint64_t* pt, uint8_t bit_index, uint8_t val) {
	if(val)
		*pt |= (1 << bit_index);
	else
		*pt &= ~(1 << bit_index);
}

uint8_t read_bit(uint64_t* pt, uint8_t bit_index) {
	return ((*pt) >> bit_index) & 1;
}

void PML_set_present(PML* pml, uint8_t p) {
	modify_bit(pml, 0, p);
}

void PML_set_rw(PML* pml, uint8_t rw) {
	modify_bit(pml, 1, rw);
}

void PML_set_us(PML* pml, uint8_t us) {
	modify_bit(pml, 2, us);
}

// 52 bit (available bits) determines if the page is allocated yet or not
void PML_set_allocated(PML* pml, uint8_t a) {
	modify_bit(pml, 52, a);
}

uint8_t PML_is_allocated(PML* pml) {
	return read_bit(pml, 52);
}

void PML_set_add(PML* pml, uint64_t* add) {
	*pml |= (((uint64_t) add) & 0xFFFFFFFFFF000); // Only bit 52:12
}

PML* PML_get_add(PML* pml) {
	uint64_t address = 0xFFFFFFFFFF000 & *pml; // Only bit 52:12
	return (PML*) address;
}

void PT_init() {
	PML* pml3 = &p3_table;
	pml3++; // Edit entry 1

	PML* pml2 = MEM_pf_alloc();
	MEM_pf_free(pml2);
	pml2 = MEM_pf_alloc();

	PML_set_present(pml3, 1);
	PML_set_us(pml3, 1);
	PML_set_rw(pml3, 1);
	PML_set_add(pml3, pml2);

	int i, j;
	for(i = 0; i < 512; ++i) {
		PML* pml2_i = pml2 + i;
		PML* pml1 = MEM_pf_alloc(); // New pml1 table for each pml2 entry, giving us 1GB of memory

		for(j = 0; j < 512; ++j) {
			PML* pml1_i = pml1 + j;
			*(uint64_t*) pml1_i = 0;
			PML_set_present(pml1_i, 1);
			PML_set_us(pml1_i, 1);
			PML_set_rw(pml1_i, 1);
			PML_set_allocated(pml1_i, 0); // set as unallocated, allocated when needed (page fault)
		}

		PML_set_add(pml2_i, pml1);
		PML_set_present(pml2_i, 1);
		PML_set_rw(pml2_i, 1);
	}
}

// Checks if address can be allocated (called from page fault), and allocate if possible
uint8_t PT_can_allocate(uint64_t add) {
	uint16_t pml4_i = (add >> (12 + 9*3)) & 0x1FF;
	uint16_t pml3_i = (add >> (12 + 9*2)) & 0x1FF;
	uint16_t pml2_i = (add >> (12 + 9*1)) & 0x1FF;
	uint16_t pml1_i = (add >> 12) & 0x1FF;
	// Physical page offset does not matter

	if(pml4_i != 0) {
		printkln("Bad pml4 index! 0x%x", pml4_i);
		return 0;
	}
	if(pml3_i != 1) {
		printkln("Bad pml3 index, not 1! 0x%x", pml4_i);
		return 0;
	}
	PML* pml3 = &p3_table;
	PML* pml2 = PML_get_add(pml3 + pml3_i);
	PML* pml1 = PML_get_add(pml2 + pml2_i);
	PML* pml1_entry = pml1 + pml1_i;
	
	if(PML_is_allocated(pml1_entry)) {
		printkln("Is already allocated, uh oh!");
		return 0;
	}

	void* phys_pf = MEM_pf_alloc();
	PML_set_add(pml1_entry, phys_pf);
	PML_set_allocated(pml1_entry, 1);
	PML_set_present(pml1_entry, 1);
	PML_set_rw(pml1_entry, 1);

	return 1;
}

/**
 * @brief 
 * 
 * @param pt 
 * @return void* 
 */
void* PT_get_phys_addy(void* pt) {
	return 0x0;
}

void* PT_alloc(uint32_t bytes) {
	// void* phys_add = MEM_pf_alloc();

	struct VirtualAddress virt_add;

	virt_add.phys_page_off = curr_pt_index++;

	void* address = (void*) &virt_add;
	return address;
}