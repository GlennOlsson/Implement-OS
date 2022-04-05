unsigned short* vgaBuff = (short*) 0xb8000;

// Console is 25x80 = 2000, we need a short (2 bytes, 16 bits) to store it
// col must be between 0-24
// row must be between 0-79
void write_to(unsigned char col, unsigned short row, unsigned short s) {
	unsigned char offset = (row * 80) + col;
	vgaBuff[offset] = s;
}

void write_str(unsigned char col, unsigned char row, char* str) {
	short offset = 0;
	char c = str[0];
	while(c != '\0') {
		short token = (0x2f << 8) | c;
		write_to(col + offset, row, token);

		offset += 1;
		c = str[offset];
	}
}

void kmain() {

	write_str(0, 0, "Hello my name is Glenn!");

	int j = 0;
	while(!j)
		asm("hlt");
}
