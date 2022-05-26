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

	// Turn on interrupts just now
	sti(1);

	// To show how stack addresses differ from heap
	uint64_t* heap_pages = MMU_alloc_pages(10);
	for(int i = 0; i < 10; i++) {
		printkln("Heap page add: %p", heap_pages + (i * 512));
	}

	for(int i = 0; i < 3; ++i) {
		uint64_t* stack_page = MMU_alloc_stack_page();
		printkln("Stack page add: %p", stack_page);
	}

	void* add = kmalloc(60);
	*(uint64_t*) add = 0x69;

	printkln("add1: %p, val: %lx", add, *(uint64_t*) add);

	kfree(add);
	add = kmalloc(64);
	printkln("add2: %p, val: %lx", add, *(uint64_t*) add);

	void* add2 = kmalloc(64);
	printkln("add3: %p, val: %lx", add2, *(uint64_t*) add2);

	// Allocate 5Mb
	uint32_t size = 5000000;
	void* big_alloc = kmalloc(size);

	printkln("Write to big allocation");
	for(int i = 0; i < size; ++i) {
		*(char*) (big_alloc + i) = 'a';
	}

	printkln("Verify big allocation writes");
	for(int i = 0; i < size; ++i) {
		if(*(char*) (big_alloc + i) != 'a') {
			printkln("NOT CORRECT FOR i=%d", i);
		}
	}

	kfree(big_alloc);

	printkln("Freed alloc, expecting PF at write");

	// Throw PF??
	*(char*) big_alloc = 50;

	volatile int j = 0;
	while(!j)
		asm("hlt");
}
