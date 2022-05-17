#include "page_table.h"
#include "memory_manager.h"
#include "vga_api.h"
#include "lib.h"

extern void ASM_set_cr3(void*);

extern uint64_t p4_table;
extern uint64_t p3_table;
extern uint64_t p2_table;

// Start of virtual address space. The variable keeps track of the next address to give out
uint64_t next_add = 0x100;

uint64_t count_allocated_addresses = 0;

uint16_t curr_pt_index = 0;
uint16_t curr_pml1_index = 0;
uint16_t curr_pml2_index = 0;
uint16_t curr_pml3_index = 0;
uint16_t curr_pml4_index = 0;

// struct PML4Content* pml4;
uint64_t* pml4;
// struct PML3Content* pml3;
uint64_t* pml3;
// struct PML2Content* pml2;
uint64_t* pml2;
// struct PML1Content* pml1;
uint64_t* pml1;
uint64_t* physical_pf;

void PT_init() {

	printkln("-2");
	int i = 0;
	// for(i = 0; i < 512; ++i) {
	// 	((uint64_t*) pml4)[i] = 0;
	// 	((uint64_t*) pml3)[i] = 0;
	// 	((uint64_t*) pml2)[i] = 0;
	// 	((uint64_t*) pml1)[i] = 0;
	// }

	pml4 = MEM_pf_alloc();
	pml3 = MEM_pf_alloc();
	pml2 = MEM_pf_alloc();
	pml1 = MEM_pf_alloc();

	printkln("-1");

	// *((uint64_t*) pml4) = ((uint64_t) p3_table) | 0b11;
	// pml4[0].present = 1;
	// pml4[0].r_w = 1;
	// pml4[0].pml3 = ((uint64_t) pml3) >> 12;


	// *((uint64_t*) pml3) = ((uint64_t) p2_table) | 0b11;

	// pml3[0].present = 1;
	// pml3[0].r_w = 1;
	// pml3[0].pml2 = ((uint64_t) pml2) >> 12;

	// for(i = 0; i < 512; ++i) {
	// 	// *((uint64_t*) (pml2 + i)) = (0x200000 * i) | 0b10000011;
	// 	// pml2[i].present = 1;
	// 	// pml2[i].r_w = 1;
	// 	// pml2[i].zero = 1;
	// 	// pml2[i].pml1 = 0x200000 * i;

	// 	*(((uint64_t*) pml2) + i) = *(((uint64_t*) &p2_table) + i);
	// }

	printkln("0");

	// Set the page frame as a newly allocated pf
	physical_pf = MEM_pf_alloc();

	for(i = 0; i < 4096; ++i) {
		physical_pf[i] = 0;
	}

	printkln("1");

	printkln("Table 4: %p", &p4_table);
	// -- WERIDEST BUG -- UNCOMMENT LINE BELOW AND CODE IN 
	// THIS FUNC WILL NOT RUN
	// printkln("Table 3: %p", &p3_table);
	printkln("Table 2: %p", &p2_table);

	// for(i = 0; i < 512; ++i) {
	// 	// *(pml4 + i) = *((&p4_table) + i);
	// 	// *(pml3 + i) = *((&p3_table) + i);
	// 	// *(pml2 + i) = *((&p2_table) + i);
	// }

	memcpy(pml4, &p4_table, 4096);
	memcpy(pml3, &p3_table, 4096);
	memcpy(pml2, &p2_table, 4096);

	// *((uint64_t*) pml4) = (uint64_t) p4_table;
	// *((uint64_t*) pml3) = (uint64_t) p3_table;

	printkln("Table 4 cont: %lx", p4_table);
	printkln("Table 3 cont: %lx", p3_table);
	printkln("Table 2 cont: %lx", p2_table);
	printkln("Table 2+1 cont: %lx", *(((uint64_t*) &p2_table) + 1));
	printkln("Table 2+511 cont: %lx", *(((uint64_t*) &p2_table) + 511));

	// *((uint64_t*) pml2) = (uint64_t) p2_table;

	printkln("PML4 cont: %lx", *((uint64_t*) pml4));
	printkln("PML3 cont: %lx", *((uint64_t*) pml3));
	printkln("PML2 cont: %lx", *((uint64_t*) pml2));
	printkln("PML2+1 cont: %lx", *(((uint64_t*) pml2) + 1));
	printkln("PML2+511 cont: %lx", *(((uint64_t*) pml2) + 511));

	ASM_set_cr3(pml4);
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
	void* phys_add = MEM_pf_alloc();

	struct VirtualAddress virt_add;

	virt_add.phys_page_off = curr_pt_index++;

	struct PML1Content pml1;
	pml1.present = 1;
	pml1.r_w = 1;
	// Only first 40 bits
	pml1.phys = (uint64_t) phys_add;

	// TODO: Remove, just for compiler
	if(pml1.u_s == 0x1)
		return 0;

	// Previous page frame is full of entries, kinda
	// 		could be de-allocated addresses in it, but screw it
	if(curr_pt_index > PAGE_SIZE)
		physical_pf = MEM_pf_alloc();


	void* address = (void*) &virt_add;
	return address;
}