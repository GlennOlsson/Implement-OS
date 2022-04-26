#include "vga_api.h"
#include "lib.h"
#include "serial.h"
#include "console.h"

#include <stdarg.h>
#include <stdint-gcc.h>

#define MAX_COL 80
#define MAX_ROW 25

unsigned short* vga_buff = (unsigned short*) 0xb8000;

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
void VGA_write_to(unsigned char col, unsigned char row, unsigned short s) {
	unsigned short offset = vga_offset(col, row);
	vga_buff[offset] = s;
}

/**
 * @brief Write char with green text and black background
 * 
 * @param col the column to start at. Must be between 0-79
 * @param row the row to start at. Must be between 0-24
 * @param str the string to write
 */
void write_char(unsigned char col, unsigned char row, const char c) {
	short token = (0x2 << 8) | c;
	VGA_write_to(col, row, token);
}

/**
 * @brief Write string with white text and green background
 * 
 * @param col the column to start at. Must be between 0-79
 * @param row the row to start at. Must be between 0-24
 * @param str the string to write
 */
void VGA_write_str(unsigned char col, unsigned char row, const char* str) {
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

char char_at(unsigned char col, unsigned char row) {
	unsigned short offset = vga_offset(col, row);
	return vga_buff[offset] & 0xFF;
}

void clear_row(unsigned char row) {
	short offset = vga_offset(0, row);
	for(char col = 0; col < MAX_COL; col++) {
		vga_buff[offset++] = 0x0000;
	}
}

void clear_at(unsigned char col, unsigned char row) {
	short offset = vga_offset(col, row);
	vga_buff[offset] = 0x0000;
}

// Scroll the console one line up
void scroll() {
	for(short row = 1; row < MAX_ROW; ++row) {
		short prev_offset = vga_offset(0, row - 1);
		short curr_offset = vga_offset(0, row);
		memcpy(vga_buff + prev_offset, vga_buff + curr_offset, 2 * MAX_COL);
	}
}

int VGA_count_rows() {
	return MAX_ROW;
}

int VGA_count_cols() {
	return MAX_COL;
}


unsigned char current_row = 0;
unsigned char current_col = 0;

// Does not erase first two characters due to prompt
void VGA_erase() {
	char int_on = cli();

	if(current_col - 1 >= 2)
		--current_col;
	clear_at(current_col, current_row);

	sti(int_on);
}

void VGA_clear() {
	char int_on = cli();

	short limit = MAX_COL * MAX_ROW;
	short index = 0;
	while(index < limit) {
		vga_buff[index++] = 0x0000;
	}
	current_col = 0;
	current_row = 0;

	sti(int_on);
}

// Returns how many chars were printed
int VGA_display_char(char c) {
	char int_on = cli();
	if(current_row == MAX_ROW) {
		scroll();
		--current_row;
		clear_row(current_row);
	}
	if(c == '\n') {
		current_row += 1;
		current_col = 0;
		
		sti(int_on);
		return 1;
	}
	if(c == '\t') {
		// Display 4 spaces
		VGA_display_char(' ');
		VGA_display_char(' ');
		VGA_display_char(' ');
		VGA_display_char(' ');

		sti(int_on);
		return 4;
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

	sti(int_on);
	return 1;
}

// Does not break line after string
// Returns amount of characters written
int VGA_display_str(const char * str) {
	char int_on = cli();

	int offset = 0;
	char c = str[offset];
	while(c != '\0') {
		VGA_display_char(c);
		c = str[++offset];
	}

	sti(int_on);

	return offset;
}

// Breaks line after the string
int VGA_display_line(const char * str) {
	char int_on = cli();

	int chars = VGA_display_str(str);
	VGA_display_char('\n');
	
	sti(int_on);

	return chars + 1; // +1 for \n
}

void print_char(char c) {
	char int_on = cli();

	VGA_display_char(c);

	sti(int_on);
}

void print_str(const char* str) {
	char int_on = cli();

	VGA_display_str(str);

	sti(int_on);
}

void print_uchar(unsigned char c) {
	unsigned long l = (unsigned long) c;
	char str[3]; // Max is 255 for uchar
	to_string(l, str, 10);
	VGA_display_str(str);
}

void print_short(short s) {
	long l = (long) s;
	char str[6]; // Min is "-32767" for uchar
	to_string(l, str, 10);
	VGA_display_str(str);
}

void print_long_hex(unsigned long l) {
	char str[20]; // Min is "-9223372036854775808"
	to_string(l, str, 16);
	VGA_display_str(str);
}

int _printk(const char* fmt, int (*print_c_f)(char), int (*print_str_f)(const char*), va_list* args) {

	int c_count = 0;
	char c = *fmt;
	while(c != '\0') {
		// if format specifier
		if(c == '%') {
			//%% %d %u %x %c %p %h[dux] %l[dux] %q[dux] %s
			c = *(++fmt);
			if(c == '%') { // literal %
				c_count += print_c_f('%');
			} else if (c == 'd') { // signed decimal
				long i = va_arg(*args, long);
				char s[20]; // max 19 digits and a minus sign
				to_string(i, s, 10);
				c_count += print_str_f(s);

			} else if (c == 'u') { // unsiged decimal
				unsigned long i = va_arg(*args, unsigned long);
				char s[10]; // max 10 digits
				to_string(i, s, 10);
				c_count += print_str_f(s);

			} else if (c == 'x') { // lowercase hex
				long i = va_arg(*args, long);
				char s[11]; //
				to_string(i, s, 16);
				c_count += print_str_f(s);
				
			} else if (c == 'c') { // character
				char c = va_arg(*args, int);
				c_count += print_c_f(c);

			} else if (c == 'p') { // pointer
				void* pt = va_arg(*args, void*);
				char s[8];
				to_string((long) pt, s, 16);
				c_count += print_str_f(s);

			}  else if (c == 'b') { // binary
				unsigned long i = va_arg(*args, unsigned long);
				char s[64];
				to_string((unsigned long) i, s, 2);
				c_count += print_str_f(s);

			} else if (c == 'h') { // %h[dux] short int
				c = *(++fmt);

				if(c == 'd') {
					short int i = va_arg(*args, int);
					char s[6]; // 5 digits and -
					to_string(i, s, 10);
					c_count += print_str_f(s);

				} else if (c == 'u') { // unsigned
					unsigned short int i = va_arg(*args, unsigned int);
					char s[5]; // 5 digits
					to_string(i, s, 10);
					c_count += print_str_f(s);

				} else if (c == 'x') { // hex
					unsigned short int i = va_arg(*args, unsigned int);
					char s[4]; // 4 hex digits
					to_string(i, s, 16);
					c_count += print_str_f(s);

				} else { // just print the %, x and value of c
					c_count += print_c_f('%');
					c_count += print_c_f('x');
					c_count += print_c_f(c);
				}
			} else if (c == 'l') { // %l[dux] long int
				c = *(++fmt);
				
				if(c == 'd') {
					long int i = va_arg(*args, long int);
					char s[21]; // 20 digits
					to_string(i, s, 10);
					c_count += print_str_f(s);
				} else if (c == 'u') { // unsigned
					unsigned long int i = va_arg(*args, unsigned long int);
					char s[20]; // 20 digits
					to_string(i, s, 10);
					c_count += print_str_f(s);
					
				} else if (c == 'x') { // hex
					unsigned long int i = va_arg(*args, unsigned long int);
					char s[8]; // 8 hex values
					to_string(i, s, 16);
					c_count += print_str_f(s);
				} else { // just print the %, l and value of c
					c_count += print_c_f('%');
					c_count += print_c_f('l');
					c_count += print_c_f(c);
				}
			} else if (c == 'q') { // %q[dux], 8 bit integer
				c = *(++fmt);

				if(c == 'd') {
					char i = va_arg(*args, int);
					char s[4]; // 3 digits and a -
					to_string(i, s, 10);
					c_count += print_str_f(s);
				} else if (c == 'u') {
					unsigned char i = va_arg(*args, int);
					char s[3]; // 3 digits
					to_string(i, s, 10);
					c_count += print_str_f(s);
				} else if (c == 'x') {
					unsigned char i = va_arg(*args, int);
					char s[2]; // 3 digits
					to_string(i, s, 16);
					c_count += print_str_f(s);
				} else { // just print the %, q and value of c
					c_count += print_c_f('%');
					c_count += print_c_f('q');
					c_count += print_c_f(c);
				}
			} else if (c == 's') { // string
				char* str = va_arg(*args, char*);
				c_count += print_str_f(str);

			} else { // Just display the two characters in plain text
				c_count += print_c_f('%');
				c_count += print_c_f(c);
			}
		} else { // plain text 
			c_count += print_c_f(c);
		}

		c = *(++fmt);
	}

	return c_count;
}

// Returns wether or not this is a prompt line
char is_prompt() {
	int prompt_length = strlen(CONSOLE_PROMPT);

	for(int i = 0; i < prompt_length; ++i) {
		char c = char_at(i, current_row);
		if(c != CONSOLE_PROMPT[i])
			return 0;
	}
	return 1;
}

int printk(const char* fmt, ...) {
	char int_on = cli();

	if(is_prompt()) {
		VGA_display_char('\n');
	}	

	va_list args;
    va_start(args, fmt);
	int c_count = _printk(fmt, &VGA_display_char, &VGA_display_str, &args);
	_printk(fmt, &SER_write_c, &SER_write_str,&args);
	va_end(args);

	sti(int_on);

	return c_count;
}

int printkln(const char* fmt, ... ) {
	char int_on = cli();

	char is_p = is_prompt();
	if(is_p) {
		VGA_display_char('\n');
	}	

	va_list args;
    va_start(args, fmt);
	int c_count = _printk(fmt, &VGA_display_char, &VGA_display_str,&args);
	VGA_display_char('\n');

	_printk(fmt, &SER_write_c, &SER_write_str,&args);
	SER_write_c('\n');

	va_end(args);

	sti(int_on);

	if(is_p) {
		CON_write_prompt();
	}

	return c_count + 1; // +1 for \n
}

int printkln_no_serial(const char* fmt, ... ) {
	char int_on = cli();

	char is_p = is_prompt();
	if(is_p) {
		VGA_display_char('\n');
	}	

	va_list args;
    va_start(args, fmt);
	int c_count = _printk(fmt, &VGA_display_char, &VGA_display_str,&args);
	VGA_display_char('\n');
	va_end(args);

	sti(int_on);

	if(is_p) {
		CON_write_prompt();
	}
	
	return c_count + 1; // +1 for \n
}

void slow_print(char* str) {
	char int_on = cli();
	while(*str != '\0') {
		VGA_display_char(*(str++));
		ugly_sleep(100);
	}
	sti(int_on);
}