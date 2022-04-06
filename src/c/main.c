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

	write_str(5, 0, "Hello my name is Glenn, and I am the absolute best skiier on this mf mountain!");
	
	write_to(79, 24, 0x2f44);

	ugly_sleep(5);



	int j = 30;

	// while(j--) {
	// 	ugly_sleep(1);
	// 	printk("Hello %s, my name is %s and I am %d years old", "Glenn", "Glenne", j);
	// }

	VGA_display_char('\n');
	VGA_display_char('\n');
	VGA_display_char('\n');
	
	print_char('!');
	print_char(' ');
	print_str("Hej jag heter glenn ");
	print_short(-69);
	print_uchar(245);
	print_long_hex(0x69420);

	while(!j)
		asm("hlt");
}
