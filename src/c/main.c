#include "vga_api.h"
#include "lib.h"
#include "ps2.h"
#include "console.h"
#include "interrupts.h"
#include "gdt.h"
#include "serial.h"
#include "multiboot_parser.h"
#include "memory_manager.h"

void kmain() {
	VGA_clear();
	printkln("\n\n");

	MEM_init();

	MUL_parse();

	setup_gdt(); // create and load new gdt from c
	load_gdt();
	load_tss();

	IRQ_set_mask(0); // Disable timer
	IRQ_clear_mask(4); // Enable COM1

	PS2_setup_keyboard(); // Config keyboard

	SER_init();

	slow_print("Hello, welcome to GlennOS!\n");
	CON_write_prompt();

	MEM_test_mem();

	// Turn on interrupts just now
	sti(1);

	volatile int j = 0;
	while(!j)
		asm("hlt");
}
