#include "vga_api.h"
#include "lib.h"
#include <stdarg.h>

#define MAX_COL 80
#define MAX_ROW 25

unsigned short* vga_buff = (short*) 0xb8000;

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
	vga_buff[offset] = s;
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
		vga_buff[offset++] = 0x0000;
	}
}

// Scroll the console one line up
void scroll() {
	for(short row = 1; row < MAX_ROW; ++row) {
		short prev_offset = vga_offset(0, row - 1);
		short curr_offset = vga_offset(0, row);
		memcpy(vga_buff + prev_offset, vga_buff + curr_offset, 2 * MAX_COL);
	}
}

unsigned char current_row = 0;
unsigned char current_col = 0;

void VGA_clear() {
	short limit = MAX_COL * MAX_ROW;
	short index = 0;
	while(index < limit) {
		vga_buff[index++] = 0x0000;
	}
}

void VGA_display_char(char c) {
	if(current_row == MAX_ROW) {
			scroll();
			--current_row;
			clear_row(current_row);
	}
	if(c == '\n') {
		current_row += 1;
		current_col = 0;
		return;
	}
	// If first char of row, clear row
	if(current_col == 0)
		clear_row(current_row);

	write_char(current_col++, current_row, c);
	if(current_col >= MAX_COL) {
		current_col = 0;
		if(current_row + 1 < MAX_ROW)
			current_row++;
		else
			scroll();
	}
}

// Does not break line after string
void VGA_display_str(const char * str) {
	char c = *str;
	while(c != '\0') {
		VGA_display_char(c);
		c = *(++str);
	}
}

// Breaks line after the string
void VGA_display_line(const char * str) {
	VGA_display_str(str);
	VGA_display_char('\n');
}

void print_char(char c) {
	VGA_display_char(c);
}

void print_str(const char* str) {
	VGA_display_str(str);
}

void print_uchar(unsigned char c) {
	unsigned long l = (unsigned long) c;
	char str[3]; // Max is 255 for uchar
	to_string(l, str, 10);
	VGA_display_str(str);
}

void print_short(short s) {
	long l = (long) s;
	char str[6]; // Max is "-32767" for uchar
	to_string(l, str, 10);
	VGA_display_str(str);
}

void print_long_hex(long l) {
	char str[20]; // Min is "-9223372036854775808"
	to_string(l, str, 16);
	VGA_display_str(str);
}


int printk(const char* fmt, ... ) {
    va_list args;
    va_start(args, fmt);

	char c = *fmt;
	while(c != '\0') {
		// if format specifier
		if(c == '%') {
			//%% %d %u %x %c %p %h[dux] %l[dux] %q[dux] %s
			c = *(++fmt);
			if(c == '%') { // literal %
				VGA_display_char('%');
			} else if (c == 'd') { // signed decimal
				long i = va_arg(args, long);
				char s[20]; // max 19 digits and a minus sign
				to_string(i, s, 10);
				VGA_display_str(s);

			} else if (c == 'u') { // unsiged decimal
				unsigned long i = va_arg(args, unsigned long);
				char s[10]; // max 10 digits
				to_string(i, s, 10);
				VGA_display_str(s);

			} else if (c == 'x') { // lowercase hex
				long i = va_arg(args, long);
				char s[11]; //
				to_string(i, s, 16);
				VGA_display_str(s);
				
			} else if (c == 'c') { // character
				char c = va_arg(args, int);
				VGA_display_char(c);

			} else if (c == 'p') { // pointer
				void* pt = va_arg(args, void*);
				char s[8];
				to_string((long) pt, s, 16);
				VGA_display_str(s);

			} else if (c == 'h') {
				
			} else if (c == 'l') {
				
			} else if (c == 'q') {
				
			} else if (c == 's') { // string
				char* str = va_arg(args, char*);
				VGA_display_str(str);

			} else { // Just display the two characters in plain text
				VGA_display_char('%');
				VGA_display_char(c);
			}
		} else { // plain text 
			VGA_display_char(c);
		}

		c = *(++fmt);
	}
	VGA_display_char('\n');
}