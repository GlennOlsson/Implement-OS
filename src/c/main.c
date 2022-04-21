#include "vga_api.h"
#include "lib.h"
#include "ps2.h"
#include "console.h"
#include "interrupts.h"
#include "gdt.h"

void kmain() {
	setup_gdt();
	load_gdt();

	slow_print("Hello, welcome to GlennOS!\n");

	// // setup_keyboard returns a pointer to a function which polls the keyboard. This function
	// // takes a function which is called with each key action
	// void (*poll_keyboard_func)(void (*key_action_func)(unsigned char)) = setup_keyboard();
	setup_keyboard();
	setup_console();

	// poll_keyboard_func(&key_action);

	uint16_t mask = IRQ_get_mask(1);
	printkln("Mask for keyboard: %d", mask);

	volatile int j = 0;

	while(!j)
		asm("hlt");
}
