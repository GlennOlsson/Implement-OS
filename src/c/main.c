#include "vga_api.h"
#include "lib.h"
#include "ps2.h"
#include "console.h"
#include "interrupts.h"
#include "gdt.h"
#include "serial.h"
#include "multiboot_parser.h"
#include "memory_manager.h"
#include "page_table.h"

void kmain() {
	VGA_clear();
	printkln("+ - - - - - - - - - +");
	printkln("|                   |");
	printkln("|      Welcome      |");
	printkln("|        To         |");
	printkln("|      GlennOS!     |");
	printkln("|                   |");
	printkln("+ - - - - - - - - - +");

	MEM_init();

	MUL_parse();

	printkln("Parsed multiboot");

	PT_init();

	setup_gdt(); // create and load new gdt from c
	load_gdt();
	load_tss();

	IRQ_set_mask(0); // Disable timer
	IRQ_clear_mask(4); // Enable COM1

	PS2_setup_keyboard(); // Config keyboard

	SER_init();

	CON_write_prompt();

	// Turn on interrupts just now
	sti(1);

	int i = 0;
	int* i_add = (int*) (((uint64_t) &i) | (1 << 30));
	printkln("&i = %p, or %p", &i, i_add);

	*i_add = 5;

	printkln("i = %d, or %d", i, *i_add);

	volatile int j = 0;
	while(!j)
		asm("hlt");
}
