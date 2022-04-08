#include "vga_api.h"
#include "lib.h"
#include "ps2.h"

void kmain() {

	printk("Hello, welcome to GlennOS!\n");

	setup_keyboard();

	printk("Setup keyboard");

	int j = 0;
	while(!j)
		asm("hlt");
}
