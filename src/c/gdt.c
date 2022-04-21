#include "gdt.h"
#include <stdint-gcc.h>
#include "lib.h"
#include "vga_api.h"

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

struct SegmentDescriptor gdt[2];

// Set to 0
void _setup_gdt_0(struct SegmentDescriptor* gdt) {
	uint32_t* uint_ptr;
	uint_ptr = (uint32_t*) gdt;

	*uint_ptr = 0;
}

// The code segment
void _setup_gdt_1(struct SegmentDescriptor* gdt) {
	gdt->exec = 1;
	gdt->desc = 1;
	gdt->present = 1;
	gdt->long_mode = 1;
}

void setup_gdt() {
	_setup_gdt_0(gdt);
	_setup_gdt_1(gdt + 1);

	uint64_t gdt1 = *((uint64_t*) gdt);
	uint64_t gdt2 = *((uint64_t*) gdt + 1);

	printkln("GDT0: %lx, GDT1: %lx", gdt1, gdt2);
}

void load_gdt() {
	char curr_int = cli();

	set_gdt((2 * 8) - 1, (uint64_t*) gdt);
	reload_segments();

	sti(curr_int);
}