unsigned short* vgaBuff = (short*) 0xb8000;

// Console is 25x80 = 2000, we need a short (2 bytes, 16 bits) to store it
// col must be between 0-24
// row must be between 0-79
void write_to(unsigned char col, unsigned short row, unsigned short s) {
	unsigned char offset = (row * 80) + col;
	vgaBuff[offset] = s;
}

void write_str(unsigned char col, unsigned char row, char* str) {
	short col_offset = 0;
	short row_offset = 0;

	short str_index = 0;
	char c = str[str_index];
	while(c != '\0') {
		short token = (0x2f << 8) | c;
		write_to(col + col_offset, row + row_offset, token);

		col_offset += 1;
		if(col_offset == 80) {
			col_offset = 0;
			row_offset += 1;
		}
		c = str[++str_index];
	}
}

void kmain() {

	write_str(5, 0, "Hello my name is Glenn, and I am the absolute best skiier on this mf mountain!");

	int j = 0;
	while(!j)
		asm("hlt");
}
