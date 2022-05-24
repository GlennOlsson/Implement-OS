#include "memory_manager.h"
#include "vga_api.h"

#include <stdint-gcc.h>

// Maximum number of address regions to avoid
#define AVOID_REGION_COUNT 6

#define nullptr 0

struct {
	// Each index i of address is the address, and the corresponding index in size is the size of the region
	uint64_t allocated_addresses[AVOID_REGION_COUNT];
	uint64_t allocated_sizes[AVOID_REGION_COUNT];

	int current_allocated_index;

	uint64_t start_address;
	uint64_t address_space_size;

} memory_structure; //Pre allocated regions

// First 8 bytes (uint64_t) of each free page has the address to the next free page (except tail which has 0)
struct {
	uint64_t page_head;
	uint64_t page_tail;
	uint32_t count;
} free_pages;

// Register span as pre-allocated
void PRE_add_allocated_span(uint64_t new_address, uint64_t new_size) {
	if(new_size == 0) // Ignore
		return;

	int curr_reg = memory_structure.current_allocated_index;

	// Spec case for first region
	if(curr_reg == -1) {
		curr_reg = 0;
		memory_structure.allocated_addresses[curr_reg] = new_address;
		memory_structure.allocated_sizes[curr_reg] = new_size;
		memory_structure.current_allocated_index = curr_reg;
		return;
	}

	uint64_t curr_addy = memory_structure.allocated_addresses[curr_reg];
	uint64_t curr_size = memory_structure.allocated_sizes[curr_reg];
	
	// printkln("Allocated addy: %lx, size: %lx", curr_addy, curr_size);

	// If new address follows last added span, or within 1 page of end, add as part of memory_structure span
	if((new_address - (curr_addy + curr_size)) <= PAGE_SIZE) {
		// Add size + diff from current address
		memory_structure.allocated_sizes[curr_reg] += new_size + (new_address - (curr_addy + curr_size));
	} else { // Else, need new entry
		curr_reg += 1;
		if(curr_reg >= AVOID_REGION_COUNT) {
			printkln("To many Pre Allocated Regions, increase constant. Now: %d", curr_reg);
			return;
		}
		memory_structure.allocated_addresses[curr_reg] = new_address;
		memory_structure.allocated_sizes[curr_reg] = new_size;
		memory_structure.current_allocated_index = curr_reg;
	}
}

// Checks that address is not in range of pre-allocated memory
// Returns 0 if is ok, else returns the end address of the span the address was in
uint64_t ok_address(uint64_t a) {
	for(int i = 0; i <= memory_structure.current_allocated_index; ++i) {
		uint64_t start = memory_structure.allocated_addresses[i];
		uint64_t end = start + memory_structure.allocated_sizes[i];

		uint64_t page_end = a + PAGE_SIZE;
		// If is within this span (excluding end), is not ok
		// Check if intervals overlap https://stackoverflow.com/questions/3269434/whats-the-most-efficient-way-to-test-if-two-ranges-overlap
		if(a <= end && start <= page_end)
			return end;
	}
	// If has not returned yet, is ok!
	return 0;
}

// Allign address so it is 4kb-aligned (or page size). Potentially adds a value to v
uint64_t align_page_size(uint64_t v) {
	uint64_t mod = v % PAGE_SIZE;
	if(mod == 0)
		return v;
	else
		return v + (PAGE_SIZE - mod);
}

// Find a free page with an address equal to or greater than start
uint64_t find_free_page(uint64_t start) {
	if(start == 0)
		start++; // will force it to not be 0, no matter the page size. Will be aligned later

	// make sure it's alligned
	start = align_page_size(start);

	uint64_t end_address = ok_address(start);
	// If != 0, means that end_address is the end address of the allocated span that the page starting with start was in
	if(end_address != 0) {
		uint64_t end_address_aligned = align_page_size(end_address);
		// Try again with the end of previous occupied interval
		return find_free_page(end_address_aligned);
	}
	// Else, free page
	return start;
}

// Add address space to linked list
void PRE_add_address_space(uint64_t start_address, uint64_t space_size) {
	uint64_t curr_address = align_page_size(start_address);
	curr_address = find_free_page(curr_address);

	//If not the first element added to the list
	//Then add the first free page of this space as page tail
	if(free_pages.page_head != 0) {
		uint64_t tail_address = free_pages.page_tail;
		uint64_t* tail_page = (uint64_t*) tail_address;

		*tail_page = curr_address;

		free_pages.page_tail = curr_address;
	} else { // If == 0, i.e. is first element in list
		free_pages.page_head = curr_address;
		free_pages.page_tail = curr_address;
	}
	free_pages.count++;

	// Set "next" as nullptr
	*((uint64_t*) curr_address) = nullptr;

	// Max address of this space
	const uint64_t max_address = start_address + space_size;

	// Add all free pages follwing the address
	while(curr_address + PAGE_SIZE <= max_address) {
		uint64_t* curr_page = (uint64_t*) curr_address;

		// Here we know that curr_address is an available page
		// Now we find the next free page

		uint64_t next_free_page = find_free_page(curr_address + PAGE_SIZE);

		// If the next free page is outside our address scope, write to 
		// nullptr to curr_page to set it as tail of linked list
		if(next_free_page + PAGE_SIZE > max_address) {
			*curr_page = nullptr;
			free_pages.page_tail = curr_address;
			break;
		} else {
			// next_free_page is a legit and free page in out memory
			// write its address to curr_page
			*curr_page = next_free_page;
			curr_address = next_free_page;
			free_pages.count++;
		}
	}
}

// Traverse free pages, returns the count of pages
int PRE_traverse() {
	uint64_t address = free_pages.page_head;

	int counter = 0;
	while(address != free_pages.page_tail) {
		counter++;
		uint64_t* page_address = (uint64_t*) address;
		uint64_t next_page = *page_address;

		address = next_page;
	}
	printkln("Free pages: %d", counter);
	return counter;
}

// Take head of free pages
void* MEM_pf_alloc(void) {
	uint64_t curr_head = free_pages.page_head;
	if(curr_head == nullptr) {
		printkln("Ran out of pages");
		asm("int $13");
		return 0;
	}
	uint64_t* curr_head_page = (uint64_t*) curr_head;

	uint64_t new_head = *curr_head_page;
	free_pages.page_head = new_head;

	free_pages.count--;

	return (void*) curr_head;
}

// Set as tail of free pages
void MEM_pf_free(void* pf) {
	uint64_t new_tail = (uint64_t) pf;

	uint64_t curr_tail = free_pages.page_tail;
	uint64_t* curr_tail_page = (uint64_t*) curr_tail;

	*curr_tail_page = new_tail;
	free_pages.page_tail = new_tail;
	
	free_pages.count++;
}

uint32_t MEM_count_free_pages() {
	return free_pages.count;
}

void MEM_init() {
	memory_structure.current_allocated_index = -1;

	memory_structure.start_address = 0;
	memory_structure.address_space_size = 0;

	free_pages.page_head = nullptr;
	free_pages.page_tail = nullptr;
	free_pages.count = 0;
}

