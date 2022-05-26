#ifndef PAGE_TABLE_H
#define PAGE_TABLE_H

#include <stdint-gcc.h>

struct CR3Content {
	uint64_t res_1: 3;

	uint64_t pwt: 1;
	uint64_t pcd: 1;

	uint64_t res_2: 7;

	uint64_t pml4: 40;

	uint64_t res_mbz: 12;
} __attribute__((packed));

struct VirtualAddress {
	uint64_t phys_page_off: 12;
	uint64_t pml1_off: 9;
	uint64_t pml2_off: 9;
	uint64_t pml3_off: 9;
	uint64_t pml4_off: 9;

	uint64_t sign_ext: 16;

} __attribute__((packed));

void PT_init();
uint8_t PT_can_allocate(uint64_t add);

uint8_t MMU_is_present(void* pt);

void PML_verbose(void*);

void *MMU_alloc_page();
void *MMU_alloc_pages(int num);
void MMU_free_page(void *);
void MMU_free_pages(void *, int num);

#endif