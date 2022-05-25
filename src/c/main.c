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

	int* i = 0;
	*i = 3;

	int allocated_addresses = 10;
	char* start_add = MMU_alloc_pages(allocated_addresses);
	char* next = MMU_alloc_page(); // to make sure we don't get the same address again

	if(start_add >= next)
		printkln("Start address bigger than next, NOT OK!!");

	// Set a value for each entry
	for(int i = 0; i < 10; ++i) {
		for(int j = 0; j < PAGE_SIZE; ++j) {
			*(start_add + (j + (i * PAGE_SIZE))) = 'a';
		}
	}

	for(int j = 0; j < PAGE_SIZE; ++j) {
		*(next + j) = 'b';
	}

	// Verify that the entries are correct, and that writing to 'next' does not manipulate the data in the 10-page address space
	for(int i = 0; i < 10; ++i) {
		for(int j = 0; j < PAGE_SIZE; ++j) {
			if(*(start_add + (j + (i * PAGE_SIZE))) != 'a') {
				printkln("NOT CORRECT FOR MULTI PAGE!! Expected: %d, Actually: %c", (j % 256), *(start_add + (j + (i * PAGE_SIZE))));
			}
		}
	}

	for(int j = 0; j < PAGE_SIZE; ++j) {
		if(*(next + j) != 'b') {
			printkln("NOT CORRECT!! %d", j);
		}
	}

	// If we get here without any prints we are all good

	MMU_free_pages(start_add, allocated_addresses);
	MMU_free_page(next);

	char* next_next = MMU_alloc_page();
	if(next >= next_next)
		printkln("next_next is lower than next, NOT OK!!");

	printkln("Is start_add present? %c", MMU_is_present(start_add) ? 'y' : 'n');

	printkln("EXPECTING PAGE FAULT AFTER THIS!");
	*start_add = 'c';
	printkln("Value of start_add: %c", *start_add);
	*(start_add + PAGE_SIZE + 1) = 'f';
	printkln("Value of start_add + page: %c", *(start_add + PAGE_SIZE + 1));
	//*next = 'd';
	//printkln("Value of next: %c", *next);
	//printkln("Value of next_next: %c", *next_next);

	volatile int j = 0;
	while(!j)
		asm("hlt");
}
