#include "vga_api.h"
#include "lib.h"
#include "ps2.h"
#include "console.h"

void kmain() {

	// slow_print("Hello, welcome to GlennOS!\n");

	// // setup_keyboard returns a pointer to a function which polls the keyboard. This function
	// // takes a function which is called with each key action
	// void (*poll_keyboard_func)(void (*key_action_func)(unsigned char)) = setup_keyboard();
	// setup_console();

	// poll_keyboard_func(&key_action);

	int j = 0;
	while(!j)
		asm("hlt");
}
