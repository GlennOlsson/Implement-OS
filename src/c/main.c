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

	int j = 1;
	while(j)
		asm("hlt");
}
