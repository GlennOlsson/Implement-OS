#include "vga_api.h"

#define MAX_COL 80
#define MAX_ROW 25

unsigned short* vgaBuff = (short*) 0xb8000;

short vga_offset(unsigned char col, unsigned char row) {
	return (row * MAX_COL) + col;
}

/**
 * @brief Write a short to a specific location in the VGA console
 * 	Console is 25x80 = 2000, we need a short (2 bytes, 16 bits) to store it
 * 
 * @param col the column to write to. Must be between 0-79
 * @param row the row to write to. Must be between 0-24
 * @param s the short to write. First byte is the attributes, second is the character
 */
void write_to(unsigned char col, unsigned char row, unsigned short s) {
	unsigned short offset = vga_offset(col, row);
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
		if(col_offset == MAX_COL) {
			col_offset = 0;
			row_offset += 1;
		}
		c = str[++str_index];
	}
}

void clear_row(unsigned char row) {
	short offset = vga_offset(0, row);
	for(char col = 0; col < MAX_COL; col++) {
		vgaBuff[offset++] = 0x0000;
	}
}

unsigned char current_row = 0;
unsigned char current_col = 0;

void VGA_clear() {
	short limit = MAX_COL * MAX_ROW;
	short index = 0;
	while(index < limit) {
		vgaBuff[index++] = 0x0000;
	}
}

void VGA_display_char(char c) {
	if(c == '\n') {
		current_row++;
		current_col = 0;
		return;
	}
	// If first char of row, clear row
	if(current_col == 0)
		clear_row(current_row);

	write_char(current_col++, current_row, c);
	if(current_col >= MAX_COL) {
		current_col = 0;
		current_row++;
	}
}

void VGA_display_str(const char * str) {
	char c = *str;
	while(c != '\0') {
		VGA_display_char(c);
		c = *(++str);
	}
}