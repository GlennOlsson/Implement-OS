#include "vga_api.h"
#include "lib.h"

//Sleeps for approximately sec seconds
void ugly_sleep(int sec) {
	int i = 0;
	int limit = 100000000 * sec;
	while(i < limit) {
		i += 1;
	}
}

void kmain() {

	printk("Hello, welcome to GlennOS!");

	int j = 0;
	while(!j)
		asm("hlt");
}
