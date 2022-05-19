#include "page_table.h"
#include "memory_manager.h"
#include "vga_api.h"
#include "lib.h"

extern void ASM_set_cr3(void*);

extern uint64_t p4_table;
extern uint64_t p3_table;
extern uint64_t p2_table;

// Start of virtual address space. The variable keeps track of the next address to give out
uint64_t next_add = 0x70000000;

uint64_t count_allocated_addresses = 0;

uint16_t curr_pt_index = 0;
uint16_t curr_pml1_index = 0;
uint16_t curr_pml2_index = 0;
uint16_t curr_pml3_index = 0;
uint16_t curr_pml4_index = 0;

uint64_t* physical_pf;

typedef uint64_t PML;

PML pml2[512] __attribute__((aligned (4096)));

void modify_bit(uint64_t* pt, uint8_t bit_index, uint8_t val) {
	if(val)
		*pt |= (1 << bit_index);
	else
		*pt |= ~(1 << bit_index);
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

void PML_set_add(PML* pml, uint64_t* add) {
	*pml |= ((uint64_t) add) & 0xFFFFFFFFFFFFF; // Only last 52 bits
}

void PT_init() {
	PML* pml3 = &p3_table;
	pml3++; // Edit entry 1

	PML_set_present(pml3, 1);
	PML_set_us(pml3, 1);
	PML_set_rw(pml3, 1);
	PML_set_add(pml3, pml2);

	for(int i = 0; i < 512; ++i) {
		PML* pml2_i = pml2 + i;
		PML_set_add(pml2_i, (uint64_t*) (uint64_t) (0x200000 * i));
		PML_set_present(pml2_i, 1);
		PML_set_rw(pml2_i, 1);
		modify_bit(pml2_i, 7, 1);
	}
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