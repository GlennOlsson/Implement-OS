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

	char* i = (char*) 0x40000000;
	*i = 5;

	void* page = MMU_alloc_page();
	printkln("Stack ptr: %p", &page);
	printkln("Read At %p: 0x%lx", page, *(uint64_t*) page);
	*(uint64_t*) page = 0x69;
	printkln("Wrote At %p: 0x%lx", page, *(uint64_t*) page);

	void* page2 = MMU_alloc_page();
	printkln("Curr At %p: 0x%lx", page2, *(uint64_t*) page2);
	*(uint64_t*) page2 = 0x79;
	printkln("Now At %p: 0x%lx", page2, *(uint64_t*) page2);
	printkln("(P1) Now At %p: 0x%lx", page, *(uint64_t*) page);

	volatile int j = 0;
	while(!j)
		asm("hlt");
}
