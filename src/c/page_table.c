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
	*pml |= (((uint64_t) add) & 0xFFFFFFFFFF000); // Only last 52 bits
}

PML* PML_get_add(PML* pml) {
	// uint64_t address = 0xFFFFFFFFFFFF8 & *pml;  // Only last 52 bits, but skip last 3 bits as they are present/rw/us
	// uint64_t address = 0xFFFFFFFFFFFFF & *pml;  // Only last 52 bits, but skip last 3 bits as they are present/rw/us
	uint64_t address = 0xFFFFFFFFFF000 & *pml;
	return (PML*) address;
}

void PT_init() {
	PML* pml3 = &p3_table;
	pml3++; // Edit entry 1

	PML* pml2 = MEM_pf_alloc();
	MEM_pf_free(pml2);
	pml2 = MEM_pf_alloc();

	printkln("pml2 add: %p", pml2);

	PML_set_present(pml3, 1);
	PML_set_us(pml3, 1);
	PML_set_rw(pml3, 1);
	PML_set_add(pml3, pml2);

	printkln("pml2 after set, add: %p", PML_get_add(pml3));

	int i, j;
	for(i = 0; i < 512; ++i) {
		PML* pml2_i = pml2 + i;
		PML* pml1 = MEM_pf_alloc(); // New pml1 table for each pml2 entry, giving us 1GB of memory

		if(i == 0)
			printkln("pml1 add for pml2[0]: %p", pml1);

		for(j = 0; j < 512; ++j) {
			PML* pml1_i = pml1 + j;
			*(uint64_t*) pml1_i = 0;
			PML_set_present(pml1_i, 1);
			PML_set_us(pml1_i, 1);
			PML_set_rw(pml1_i, 1);
			PML_set_allocated(pml1_i, 0); // set as unallocated, allocated when needed (page fault)
			PML_set_add(pml1_i, (void*) 0x69000);
			if(i == 0 && j < 2) {
				printkln("PLM1 LOW i, add: %p, pointer: %p", pml1_i, PML_get_add(pml1_i));
			}
		}

		PML_set_add(pml2_i, pml1);
		PML_set_present(pml2_i, 1);
		PML_set_rw(pml2_i, 1);
	}

	printkln("pml2 (end) after set, add: %p", PML_get_add(1 + &p3_table));
}

// Checks if address can be allocated (called from page fault), and allocate if possible
uint8_t PT_can_allocate(uint64_t add) {
	uint16_t pml4_i = (add >> (12 + 9*3)) & 0x1FF;
	uint16_t pml3_i = (add >> (12 + 9*2)) & 0x1FF;
	uint16_t pml2_i = (add >> (12 + 9*1)) & 0x1FF;
	uint16_t pml1_i = (add >> 12) & 0x1FF;
	uint16_t phys_pf_i = add & 0xFFF;

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
	printkln("Got plm2: %p, index: %d", pml2, pml2_i);
	printkln("Dir from p3_table: %p", PML_get_add(1 + &p3_table));
	PML* pml1 = PML_get_add(pml2 + pml2_i);
	printkln("Got plm1: %p, index: %d", pml1, pml1_i);
	PML* pml1_entry = pml1 + pml1_i;

	printkln("plm1_entry: %p", pml1_entry);

	printkln("phys_pf index: %d", phys_pf_i);

	void* pf_ptr = PML_get_add(pml1_entry);
	
	uint8_t is_allocated = PML_is_allocated(pml1_entry);

	printkln("is allocated?: %c", is_allocated == 1 ? 'y' : 'n');
	if(is_allocated) {
		printkln("Is already allocated, uh oh! Add: %p", pf_ptr);
		return 0;
	}

	void* phys_pf = MEM_pf_alloc();
	PML_set_add(pml1_entry, phys_pf);
	PML_set_allocated(pml1_entry, 1);
	PML_set_present(pml1_entry, 1);
	PML_set_rw(pml1_entry, 1);

	printkln("pml2: %p, pml2_i: %d", pml2, pml2_i);
	printkln("pml1: %p, pml1_i: %d", pml1, pml1_i);
	printkln("pml1_entry: %lx", *pml1_entry);
	printkln("pml1_entry address: %p", PML_get_add(pml1_entry));

	printkln("Freed page \"on-demand\", %p", phys_pf);

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