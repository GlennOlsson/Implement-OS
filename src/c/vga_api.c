#include "vga_api.h"

unsigned short* vgaBuff = (short*) 0xb8000;

/**
 * @brief Write a short to a specific location in the VGA console
 * 	Console is 25x80 = 2000, we need a short (2 bytes, 16 bits) to store it
 * 
 * @param col the column to write to. Must be between 0-79
 * @param row the row to write to. Must be between 0-24
 * @param s the short to write. First byte is the attributes, second is the character
 */
void write_to(unsigned char col, unsigned char row, unsigned short s) {
	unsigned short offset = (row * ((char) 80)) + col;
	vgaBuff[offset] = s;
}

/**
 * @brief Write char with white text and green background
 * 
 * @param col the column to start at. Must be between 0-79
 * @param row the row to start at. Must be between 0-24
 * @param str the string to write
 */
void write_char(unsigned char col, unsigned char row, const char c) {
	short token = (0x2f << 8) | c;
	write_to(col, row, token);
}

/**
 * @brief Write string with white text and green background
 * 
 * @param col the column to start at. Must be between 0-79
 * @param row the row to start at. Must be between 0-24
 * @param str the string to write
 */
void write_str(unsigned char col, unsigned char row, const char* str) {
	short col_offset = 0;
	short row_offset = 0;

	short str_index = 0;
	char c = str[str_index];
	while(c != '\0') {
		write_char(col + col_offset, row + row_offset, c);

		col_offset += 1;
		if(col_offset == 80) {
			col_offset = 0;
			row_offset += 1;
		}
		c = str[++str_index];
	}
}

void VGA_clear(void) {
	short limit = 25 * 80;
	short index = 0;
	while(index < limit) {
		vgaBuff[index++] = 0x0000;
	}
}
void VGA_display_char(char c) {
	write_char(0, 0, c);
}
void VGA_display_str(const char * str) {
	write_str(0, 0, str);
}