#include "vga_api.h"
#include "lib.h"
#include "ps2.h"
#include "console.h"
#include "interrupts.h"
#include "gdt.h"
#include "serial.h"

void kmain() {
	VGA_clear();

	setup_gdt(); // create and load new gdt from c
	load_gdt();
	load_tss();

	IRQ_set_mask(0); // Disable timer
	IRQ_clear_mask(4); // Enable COM1

	setup_keyboard(); // Config keyboard

	SER_init();

	slow_print("Hello, welcome to GlennOS!\n");
	write_promtp();

	// Turn on interrupts just now
	sti(1);

	volatile int j = 0;
	while(!j)
		asm("hlt");
}
