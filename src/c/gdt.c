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
	uint8_t desc: 1;
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
	gdt_entry->desc = 1;
	gdt_entry->present = 1;
	gdt_entry->long_mode = 1;
}

// The TSS
void _setup_gdt_2(uint64_t* _gdt) {
	struct SegmentDescriptor* lower_gdt_entry = (struct SegmentDescriptor*) _gdt;
	uint64_t* upper_bytes = _gdt + 1; // The part of SSD of 32 bit Base + Reserved

	*_gdt = 0;
	*upper_bytes = 0;

	uint64_t address = (uint64_t) tss;

	uint16_t base_1 = address & 0xFFFF;
	uint8_t base_2 = (address >> 16) & 0xFF;
	uint8_t base_3 = (address >> 24) & 0xFF;
	uint8_t base_4 = (address >> 32) & 0xFFFFFFFF;

	lower_gdt_entry->base_1 = base_1;
	lower_gdt_entry->base_2 = base_2;
	lower_gdt_entry->base_3 = base_3;
	*upper_bytes = base_4;

	uint32_t limit = (4 * TSS_ENTRIES) - 1; // 26 rows with 4 bytes each
	uint16_t limit_1 = limit & 0xFFFF;
	uint8_t limit_2 = (limit >> 16) & 0xF; // only last 4 bits
	lower_gdt_entry->limit_1 = limit_1;
	lower_gdt_entry->limit_2 = limit_2;

	lower_gdt_entry->present = 1;
	lower_gdt_entry->access = 1;
	lower_gdt_entry->exec = 1;

	lower_gdt_entry->size = 1;


	for(int i = 0; i < 16; ++i) {
		ist_1[i] = 0;
		ist_2[i] = 0;
	}

	//printkln("ist1: %lx, ist2: %p, ist3: %p, ist4: %p", ((uint64_t) ist_1) & 0xFFFFFFFF, ist_2, ist_3, ist_4);

	// Set all entries to 0
	for(int i = 0; i < TSS_ENTRIES; ++i) {
		if(i == 9) {
			// tss[i+1] = ((uint64_t) ist_1[7]) & 0xFFFFFFFF;
			// tss[i] = (((uint64_t) ist_1[7]) >> 32) & 0xFFFFFFFF;
			tss[i+1] = ((uint64_t) ist1_stack_top) & 0xFFFFFFFF;
			tss[i] = (((uint64_t) ist1_stack_top) >> 32) & 0xFFFFFFFF;
			// tss[i] = 0;
			// tss[i+1] = 0;
			i+=1;
		} else if(i == 11) {
			tss[i+1] = ((uint64_t) ist_2) & 0xFFFFFFFF;
			tss[i] = (((uint64_t) ist_2) >> 32) & 0xFFFFFFFF;
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