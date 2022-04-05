unsigned short* vgaBuff = (short*) 0xb8000;

void kmain() {

	vgaBuff[0] = 0x2f6c;

	int j = 0;
	while(!j)
		asm("hlt");
}
