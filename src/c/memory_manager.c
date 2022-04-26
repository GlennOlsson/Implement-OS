#include "memory_manager.h"
#include "vga_api.h"

#include <stdint-gcc.h>

// Maximum number of address regions to avoid
#define AVOID_REGION_COUNT 10

struct {
	// Each index i of address is the address, and the corresponding index in size is the size of the region
	uint64_t address[AVOID_REGION_COUNT];
	uint64_t size[AVOID_REGION_COUNT];

	int current_region;

} pre_a_r; //Pre allocated regions

void PRE_add_span(uint64_t new_address, uint64_t new_size) {
	uint64_t curr_addy = pre_a_r.address[pre_a_r.current_region];
	uint64_t curr_size = pre_a_r.size[pre_a_r.current_region];
	
	// If new address follows last added span, add as part of pre_a_r span
	if(curr_addy + curr_size == new_address) {
		pre_a_r.size[pre_a_r.current_region] += new_size;
	} else { // Else, need new entry
		pre_a_r.current_region += 1;
		if(pre_a_r.current_region >= AVOID_REGION_COUNT) {
			printkln("To many Pre Allocated Regions, increase constant. Now: %d", pre_a_r.current_region);
			return;
		}
		pre_a_r.address[pre_a_r.current_region] = new_address;
		pre_a_r.size[pre_a_r.current_region] = new_size;
	}
}

void PRE_print() {
	for(int i = 0; i <= pre_a_r.current_region; ++i) {
		uint64_t address = pre_a_r.address[i];
		uint64_t size = pre_a_r.size[i];

		printkln("From %lx, to %lx, size %ld", address, address + size, size);
	}
}

void MEM_init() {
	pre_a_r.current_region = 0;
}