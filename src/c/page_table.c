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

uint16_t curr_pf_index = 0;
uint16_t curr_pml1_index = 0;
uint16_t curr_pml2_index = 0;
uint16_t curr_pml3_index = 1;

uint64_t* physical_pf;

typedef uint64_t PML;

void modify_bit(uint64_t* pt, uint8_t bit_index, uint8_t val) {
	if(val) // set
		*pt |= (1ULL << bit_index);
	else // clear
		*pt &= ~(1ULL << bit_index);
}

uint8_t read_bit(uint64_t* pt, uint8_t bit_index) {
	return ((*pt) >> bit_index) & 1;
}

void PML_clear(PML* pml) {
	*pml = 0;
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

// 52nd bit (1st available bits) determines if the page is allocated yet or not
void PML_set_allocated(PML* pml, uint8_t a) {
	modify_bit(pml, 52, a);
}

uint8_t PML_is_allocated(PML* pml) {
	return read_bit(pml, 52);
}

void PML_set_add(PML* pml, void* add) {
	*pml |= (((uint64_t) add) & 0xFFFFFFFFFF000); // Only bit 52:12
}

PML* PML_get_add(PML* pml) {
	uint64_t address = 0xFFFFFFFFFF000 & *pml; // Only bit 52:12
	return (PML*) address;
}

// Get the lowest page table entry from an address
PML* PML_get_pml1(uint64_t add) {
	// uint16_t pml4_i = (add >> (12 + 9*3)) & 0x1FF;
	uint16_t pml3_i = (add >> (12 + 9*2)) & 0x1FF;
	uint16_t pml2_i = (add >> (12 + 9*1)) & 0x1FF;
	uint16_t pml1_i = (add >> 12) & 0x1FF;
	// Physical page offset does not matter

	// if(pml4_i != 0) {
	// 	printkln("Bad pml4 index! 0x%x", pml4_i);
	// 	return 0;
	// }
	// if(pml3_i != 1) {
	// 	printkln("Bad pml3 index, not 1! 0x%x", pml4_i);
	// 	return 0;
	// }
	PML* pml3 = &p3_table;// PML_get_add(pml4_i + &p4_table);
	PML* pml2 = PML_get_add(pml3 + pml3_i);
	PML* pml1 = PML_get_add(pml2 + pml2_i);
	PML* pml1_entry = pml1 + pml1_i;
	
	return pml1_entry;
}

void PT_init() {
	// Mark address nullptr as not present
	PML* pml1_0 = PML_get_pml1(nullptr);
	PML_set_present(pml1_0, 0);


	PML* pml3 = &p3_table;
	pml3++; // Edit entry 1

	PML* pml2 = MEM_pf_alloc();
	MEM_pf_free(pml2);
	pml2 = MEM_pf_alloc();

	PML_clear(pml3);
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
			
			PML_clear(pml1_i);
			
			PML_set_present(pml1_i, 0);
			PML_set_us(pml1_i, 1);
			PML_set_rw(pml1_i, 1);
			PML_set_add(pml1_i, nullptr);
			PML_set_allocated(pml1_i, 0); // set as unallocated, allocated when needed (page fault)
		}

		PML_clear(pml2_i);
		PML_set_add(pml2_i, pml1);
		PML_set_present(pml2_i, 1);
		PML_set_rw(pml2_i, 1);
	}
}

// Checks if address can be allocated (called from page fault), and allocate if possible
// returns 1 if could allocate new page, 0 if not
uint8_t PT_can_allocate(uint64_t add) {
	printkln("Can alloc?");
	PML* pml1_entry = PML_get_pml1(add);
	
	if(PML_is_allocated(pml1_entry)) {
		printkln("Is already allocated, uh oh!");
		return 0;
	}

	printkln("PRE PML1 entry: %lx", *pml1_entry);

	void* phys_pf = MEM_pf_alloc();
	if(phys_pf == nullptr) {
		printkln("Out of free pages");
		return 0;
	}
	PML_clear(pml1_entry);

	printkln("'PML1 entry: %lx", *pml1_entry);

	PML_set_add(pml1_entry, phys_pf);
	PML_set_allocated(pml1_entry, 0);
	PML_set_present(pml1_entry, 1);
	PML_set_us(pml1_entry, 1);
	PML_set_rw(pml1_entry, 1);

	printkln("PML1 entry: %lx", *pml1_entry);
	printkln("Phys add: %p", phys_pf);
	printkln("Is allocated: %c", PML_is_allocated(pml1_entry) == 1 ? 'y' : 'n');

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

uint64_t virt_as_int(struct VirtualAddress* a) {
	return *((uint64_t*) a);
}

void *MMU_alloc_page() {
	struct VirtualAddress address;
	curr_pml1_index += 1;
	if(curr_pml1_index >= 512) {
		curr_pml1_index = 0;
		curr_pml2_index += 1;
	}
	if(curr_pml2_index >= 512) {
		curr_pml2_index = 0;
		curr_pml3_index += 1;
	}
	if(curr_pml3_index > 1) {
		printkln("MUST FIX; PML3 index is too big: %d", curr_pml3_index);
		asm("int $14");
		return nullptr;
	}

	address.phys_page_off = curr_pf_index;
	address.pml1_off = curr_pml1_index;
	address.pml2_off = curr_pml2_index;
	address.pml3_off = curr_pml3_index;
	address.pml4_off = 0;
	address.sign_ext = 0; // Sign extending 0 (pml4) is 0

	PML* pml1_entry = PML_get_pml1(virt_as_int(&address));
	PML_set_add(pml1_entry, nullptr);
	PML_set_allocated(pml1_entry, 0); // Mark unallocated, deman allocation is active

	return (void*) virt_as_int(&address);
}

// void *MMU_alloc_pages(int num) {

// }

// void MMU_free_page(void *) {

// }

// void MMU_free_pages(void *, int num) {

// }
