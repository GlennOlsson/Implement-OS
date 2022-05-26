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
#include "buffer.h"

void kmain() {
	// Dissable interrupts in case they are on
	cli(0);

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

	// char* i = (char*) 286000;
	// *i = 3;

	char* add = MMU_alloc_page(); 

	// outb(0x0, 0x3F8);
	// asm("int $38");

	// volatile int* k = (int*) 0x001;
	// *k = 5;

	// printkln("Att add %p: %d", add, *add);
	// printkln("Att add %p: %d", i, *i);

	*add = 0x69;

	// printkln("Att add %p: %d", add, *add);
	// printkln("Att add %p: %d", i, *i);

	MMU_free_page(add);

	// printkln("Freed %p", add);

	*add = 0;

	// printkln("Not here");


	volatile int j = 0;
	while(!j)
		asm("hlt");
}
