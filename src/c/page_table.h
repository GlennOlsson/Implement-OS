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

struct PML4Content {
	uint64_t present: 1;
	uint64_t r_w: 1; // Read/write, writeable if set to 1
	uint64_t u_s: 1; // User/supervisor, if 1 usermode code can access page
	uint64_t pwt: 1;
	uint64_t pcd: 1;
	uint64_t a: 1;

	uint64_t ign: 1;
	uint64_t mbz: 2;
	uint64_t avl: 3;

	uint64_t pml3: 40;

	uint64_t available: 11;
	uint64_t nx: 1;

} __attribute__((packed));

struct PML3Content {
	uint64_t present: 1;
	uint64_t r_w: 1;
	uint64_t u_s: 1;
	uint64_t pwt: 1;
	uint64_t pcd: 1;
	uint64_t a: 1;

	uint64_t ign: 1;
	uint64_t zero: 1;
	uint64_t mbz: 1;
	uint64_t avl: 3;

	uint64_t pml2: 40;

	uint64_t available: 11;
	uint64_t nx: 1;

} __attribute__((packed));

struct PML2Content {
	uint64_t present: 1;
	uint64_t r_w: 1;
	uint64_t u_s: 1;
	uint64_t pwt: 1;
	uint64_t pcd: 1;
	uint64_t a: 1;

	uint64_t ign_1: 1;
	uint64_t zero: 1;
	uint64_t ign_2: 1;
	uint64_t avl: 3;

	uint64_t pml1: 40;

	uint64_t available: 11;
	uint64_t nx: 1;

} __attribute__((packed));

struct PML1Content {
	uint64_t present: 1;
	uint64_t r_w: 1;
	uint64_t u_s: 1;
	uint64_t pwt: 1;
	uint64_t pcd: 1;
	uint64_t a: 1;

	uint64_t d: 1;
	uint64_t pat: 1;
	uint64_t g: 1;

	uint64_t avl: 3;

	uint64_t phys: 40;

	uint64_t available: 11;
	uint64_t nx: 1;

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

#endif