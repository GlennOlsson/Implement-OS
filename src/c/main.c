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
#include "allocator.h"

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

	MAL_init();

	// Turn on interrupts just now
	sti(1);

	// uint64_t* heap_pages = MMU_alloc_pages(10);
	// for(int i = 0; i < 10; i++) {
	// 	printkln("Heap page add: %p", heap_pages + (i * 512));
	// }

	// for(int i = 0; i < 3; ++i) {
	// 	uint64_t* stack_page = MMU_alloc_stack_page();
	// 	printkln("Stack page add: %p", stack_page);
	// }

	kmalloc(60);

	volatile int j = 0;
	while(!j)
		asm("hlt");
}
