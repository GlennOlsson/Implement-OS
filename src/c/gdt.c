#include "gdt.h"
#include <stdint-gcc.h>
#include "lib.h"
#include "vga_api.h"

#define GDT_ENTRIES 4 // 1 zero entry, 1 code entry, 2 entries for the TSS SSD
#define TSS_ENTRIES 26

// From gdt_loader.asm
extern void set_gdt(uint16_t size, uint64_t* address);
extern void reload_segments();

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

uint64_t gdt[GDT_ENTRIES]; 

typedef uint32_t TSS_Entry;
TSS_Entry tss[TSS_ENTRIES]; // 26 entries in the table

// Set to 0
void _setup_gdt_0(uint64_t* _gdt) {
	struct SegmentDescriptor* gdt_entry = (struct SegmentDescriptor*) _gdt;

	uint32_t* uint_ptr;
	uint_ptr = (uint32_t*) gdt_entry;

	*uint_ptr = 0;
}

// The code segment
void _setup_gdt_1(uint64_t* _gdt) {
	struct SegmentDescriptor* gdt_entry = (struct SegmentDescriptor*) _gdt;

	gdt_entry->exec = 1;
	gdt_entry->desc = 1;
	gdt_entry->present = 1;
	gdt_entry->long_mode = 1;
}

// The TSS
void _setup_gdt_2(uint64_t* _gdt) {
	struct SegmentDescriptor* lower_gdt_entry = (struct SegmentDescriptor*) _gdt;
	uint64_t* upper_bytes = _gdt + 1; // The part of SSD of 32 bit Base + Reserved

	uint64_t address = (uint64_t) tss;

	uint16_t base_1 = address & 0xFFFF;
	uint8_t base_2 = (address >> 16) & 0xFF;
	uint8_t base_3 = (address >> 24) & 0xFF;
	uint8_t base_4 = (address >> 32) & 0xFFFFFFFF;

	lower_gdt_entry->base_1 = base_1;
	lower_gdt_entry->base_2 = base_2;
	lower_gdt_entry->base_3 = base_3;
	*upper_bytes = base_4;

	uint32_t limit = (4 * 26) - 1; // 26 rows with 4 bytes each
	uint16_t limit_1 = limit & 0xFFFF;
	uint8_t limit_2 = (limit >> 16) & 0xF; // only last 4 bits
	lower_gdt_entry->limit_1 = limit_1;
	lower_gdt_entry->limit_2 = limit_2;

	lower_gdt_entry->present = 1;
	lower_gdt_entry->access = 1;
	lower_gdt_entry->exec = 1;

	lower_gdt_entry->size = 1;

	// Set all entries to 0
	for(int i = 0; i < TSS_ENTRIES; ++i) {
		if(i != TSS_ENTRIES - 1)
			tss[i] = 0;
		else 
			tss[i] = 0x680000; // First 16 bits unused (reserved), then 104 (size of table). Sets IOPB
	}
}

void setup_gdt() {
	_setup_gdt_0(gdt);
	_setup_gdt_1(gdt + 1);
	_setup_gdt_2(gdt + 2);
}

void load_gdt() {
	char curr_int = cli();

	// GDT Size and location
	set_gdt((GDT_ENTRIES * 8) - 1, (uint64_t*) gdt);
	reload_segments();

	print_char('\n');

	sti(curr_int);
}

void load_tss() {
	asm("ltr 24"); // 3 * 8 - 1, offset in GDT
}