
#ifndef VGA_API_H
#define VGA_API_H


// Lowest level
void VGA_write_to(unsigned char col, unsigned char row, unsigned short s);
void VGA_write_str(unsigned char col, unsigned char row, const char* str);

// Actual API
int VGA_count_rows();
int VGA_count_cols();

void VGA_erase(void);
void VGA_clear(void);
int VGA_display_char(char);
int VGA_display_str(const char *);
int VGA_display_line(const char *);

int printk(const char* fmt, ...) __attribute__ ((format (printf, 1, 2)));
int printkln(const char* fmt, ...) __attribute__ ((format (printf, 1, 2)));
int printkln_no_serial(const char* fmt, ... ) __attribute__ ((format (printf, 1, 2)));

void VGA_print_char(char);
void VGA_print_str(const char *);
void VGA_print_uchar(unsigned char);
void VGA_print_short(short);
void VGA_print_long_hex(unsigned long);

void slow_print(char*);

#endif