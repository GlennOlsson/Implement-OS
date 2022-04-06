
// Lowest level
void write_to(unsigned char col, unsigned char row, unsigned short s);
void write_str(unsigned char col, unsigned char row, const char* str);

// Actual API
void VGA_clear(void);
void VGA_display_char(char);
void VGA_display_str(const char *);
void VGA_display_line(const char *);

int printk(const char* fmt, ...) __attribute__ ((format (printf, 1, 2)));