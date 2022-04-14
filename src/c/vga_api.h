
#ifndef VGA_API_H
#define VGA_API_H
// Lowest level
void write_to(unsigned char col, unsigned char row, unsigned short s);
void write_str(unsigned char col, unsigned char row, const char* str);

// Actual API
void VGA_erase(void);
void VGA_clear(void);
void VGA_display_char(char);
int VGA_display_str(const char *);
int VGA_display_line(const char *);

int printk(const char* fmt, ...) __attribute__ ((format (printf, 1, 2)));
int printkln(const char* fmt, ...) __attribute__ ((format (printf, 1, 2)));

void print_char(char);
void print_str(const char *);
void print_uchar(unsigned char);
void print_short(short);
void print_long_hex(unsigned long);

void slow_print(char*);

#endif