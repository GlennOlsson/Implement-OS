#include "gdt.h"
#include <stdint-gcc.h>
#include "lib.h"
#include "vga_api.h"

#define GDT_ENTRIES 4 // 1 zero entry, 1 code entry, 2 entries for the TSS SSD
#define TSS_ENTRIES 26

// From gdt_loader.asm
extern void _load_tss(uint16_t size);
extern void reload_segments();

extern void* ist1_stack_top;
extern void* ist2_stack_top;
extern void* ist3_stack_top;

struct SegmentDescriptor {
	uint16_t limit_1;
	uint16_t base_1;
	uint8_t base_2;

	//access byte
	uint8_t access: 1;
	uint8_t rw: 1;
	uint8_t direction: 1;
	uint8_t exec: 1;
	uint8_t desc_type: 1;
	uint8_t dpl: 2;
	uint8_t present: 1;

	uint8_t limit_2: 4;
	//Flags
	uint8_t res: 1;
	uint8_t long_mode: 1;
	uint8_t size: 1;
	uint8_t granularity: 1;

	uint8_t base_3;

} __attribute__((packed));


struct SystemSegmentDescriptor {
	uint16_t limit_1;
	uint16_t base_1;
	uint8_t base_2;

	//access byte
	uint8_t type: 4;
	uint8_t desc_type: 1;
	uint8_t dpl: 2;
	uint8_t present: 1;

	uint8_t limit_2: 4;
	//Flags
	uint8_t res_1: 1;
	uint8_t long_mode: 1;
	uint8_t size: 1;
	uint8_t granularity: 1;

	uint8_t base_3;

	uint32_t base_4;

	uint32_t res_2;
} __attribute__((packed));

uint64_t gdt[GDT_ENTRIES]; // 8 bytes per entry

struct {
	uint16_t size;
	uint64_t address;
} __attribute__((packed)) load_gdt_struct;

typedef uint32_t TSS_Entry;
TSS_Entry tss[TSS_ENTRIES]; // 26 entries in the table

uint64_t ist_1[16]; // Stack of 8x8-bytes
uint64_t ist_2[16]; // Stack of 8x8-bytes
uint64_t ist_3[16]; // Stack of 8x8-bytes
uint64_t ist_4[16]; // Stack of 8x8-bytes

// Set to 0
void _setup_gdt_0(uint64_t* gdt) {
	*gdt = 0;
}

// The code segment
void _setup_gdt_1(uint64_t* _gdt) {
	struct SegmentDescriptor* gdt_entry = (struct SegmentDescriptor*) _gdt;

	*_gdt = 0;

	gdt_entry->exec = 1;
	gdt_entry->desc_type = 1;
	gdt_entry->present = 1;
	gdt_entry->long_mode = 1;
}

// The TSS
void _setup_gdt_2(uint64_t* _gdt) {
	struct SystemSegmentDescriptor* tss_segment_desc = (struct SystemSegmentDescriptor*) _gdt;

	*_gdt = 0;

	uint64_t address = (uint64_t) tss;

	uint16_t base_1 = address & 0xFFFF;
	uint8_t base_2 = (address >> 16) & 0xFF;
	uint8_t base_3 = (address >> 24) & 0xFF;
	uint32_t base_4 = (address >> 32) & 0xFFFFFFFF;

	tss_segment_desc->base_1 = base_1;
	tss_segment_desc->base_2 = base_2;
	tss_segment_desc->base_3 = base_3;
	tss_segment_desc->base_4 = base_4;

	uint32_t limit = (4 * TSS_ENTRIES) - 1; // 26 rows with 4 bytes each
	uint16_t limit_1 = limit & 0xFFFF;
	uint8_t limit_2 = (limit >> 16) & 0xF; // only last 4 bits
	tss_segment_desc->limit_1 = limit_1;
	tss_segment_desc->limit_2 = limit_2;

	tss_segment_desc->present = 1;
	tss_segment_desc->dpl = 0;
	tss_segment_desc->desc_type = 0;
	tss_segment_desc->type = 0x9;

	tss_segment_desc->res_1 = 0x0;
	tss_segment_desc->granularity = 0x0;
	tss_segment_desc->long_mode = 0x0;
	tss_segment_desc->granularity = 0x0;

	tss_segment_desc->res_2 = 0x0;

	// tss_segment_desc->access = 1;
	// tss_segment_desc->exec = 1;

	//tss_segment_desc->size = 0;
	//tss_segment_desc->long_mode = 1;


	for(int i = 0; i < 16; ++i) {
		ist_1[i] = 0;
		ist_2[i] = 0;
	}

	*((uint64_t*) ist1_stack_top) = 0;
	*((uint64_t*) ist2_stack_top) = 0;

	//printkln("ist1: %lx, ist2: %p, ist3: %p, ist4: %p", ((uint64_t) ist_1) & 0xFFFFFFFF, ist_2, ist_3, ist_4);

	// Set all entries to 0
	for(int i = 0; i < TSS_ENTRIES; ++i) {
		if(i == 9) {
			// tss[i+1] = ((uint64_t) ist_1[7]) & 0xFFFFFFFF;
			// tss[i] = (((uint64_t) ist_1[7]) >> 32) & 0xFFFFFFFF;
			tss[i] = ((uint64_t) ist1_stack_top) & 0xFFFFFFFF;
			tss[i+1] = (((uint64_t) ist1_stack_top) >> 32) & 0xFFFFFFFF;
			// tss[i] = 0;
			// tss[i+1] = 0;
			i+=1;
		} else if(i == 11) {
			tss[i] = ((uint64_t) ist2_stack_top) & 0xFFFFFFFF;
			tss[i+1] = (((uint64_t) ist2_stack_top) >> 32) & 0xFFFFFFFF;
			i+=1;
		}
		else if(i == TSS_ENTRIES - 1)
			tss[i] = 0x680000; // Sets IOPB, First 16 bits unused (reserved), then 104 (size of table)
		else 
			tss[i] = 0;

		// if(i == 12)
		// 	tss[i] = ((uint64_t) ist_2) & 0xFFFFFFFF;
		// else if(i == 11)
		// 	tss[i] = (((uint64_t) ist_2) >> 32) & 0xFFFFFFFF;
		// if(i == 14)
		// 	tss[i] = ((uint64_t) ist_3) & 0xFFFFFFFF;
		// else if(i == 13)
		// 	tss[i] = (((uint64_t) ist_3) >> 32) & 0xFFFFFFFF;
		// if(i == 16)
		// 	tss[i] = ((uint64_t) ist_4) & 0xFFFFFFFF;
		// else if(i == 15)
		// 	tss[i] = (((uint64_t) ist_4) >> 32) & 0xFFFFFFFF;
	}
}

void setup_gdt() {
	_setup_gdt_0(gdt);
	_setup_gdt_1(gdt + 1);
	_setup_gdt_2(gdt + 2);
}

void load_gdt() {
	char curr_int = cli();

	load_gdt_struct.size = (GDT_ENTRIES * 8) - 1;
	load_gdt_struct.address = (uint64_t) gdt;

	asm(
		"lgdt (%0); "
		"call reload_segments"
			: 
			: "Nd"(&load_gdt_struct));

	sti(curr_int);
}

void load_tss() {
	// Cannot even write "Welcome" before faults if anything but 16, i.e. it is loaded!
	_load_tss(2*8); // offset in GDT, should be 16 as there are 2 x 8-byte selectors before
}