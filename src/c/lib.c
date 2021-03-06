#include "lib.h"
#include "stddef.h"
#include "vga_api.h"

void* memset(void* dst, int i, size_t n) {
	unsigned char c = (unsigned char) i;
	unsigned char* p = dst;
	while(n-- > 0) {
		*(p++) = c;
	}
	return dst;
}

void* memcpy(void* dest, const void* src, size_t n) {
	char* d = dest;
	const char* s = src;
	while(n-- > 0) {
		*(d++) = *(s++);
	}

	return dest;
}

size_t strlen(const char* s) {
	size_t size = 0;
	while(*(s++) != '\0')
		size += 1;
	return size;
}

char* strcpy(char* dest, const char* src) {
	size_t index = 0;
	char c = src[index];
	while(c != '\0') {
		dest[index] = c;

		index++;
		c = src[index];
	}

	return dest;
}

int strcmp(const char* s1, const char* s2) {
	size_t index = 0;
	while (s1[index] != '\0' && s2[index] != '\0') {
		char diff = s1[index] - s2[index];
		if(diff != 0)
			return diff;

		index += 1;
	}
	// If here, check final char. Either both are \0, or one is \0 and the other is a regular char, 
	// i.e. this diff comp works fine
	return s1[index] - s2[index];
}

const char* strchr(const char* s, int c) {
	while(*s != (char) c && *s != '\0')
		s++;
	
	return *s == (char) c ? s : NULL;
}

// Convert integer to string in base
void to_string(long _i, char* s, long base) {
	if(base == 0) {
		printkln("WHAT");
		return;		
	}

	size_t index = 0;
	if(_i == 0) {
		s[0] = '0';
		s[1] = '\0';
		return;
	}
	// If not base 10, assume is unsigned long
	char is_negative = base == 10 && _i < 0;
	if(is_negative)
		_i *= -1;

	unsigned long i = (unsigned long) _i;

	while(i != 0) {
		unsigned long remainder = i % base;
		// If the remainder is bigger than 9, we don't want to choose ascii ;: etc. but rather
		// abc etc.
		s[index++] = remainder >= 10 ? (remainder - 10) + 'a' : remainder + '0';
		i /= base;
	}
	if(is_negative)
		s[index++] = '-';

	s[index] = '\0';
	
	size_t start = 0;
	size_t end = index - 1;

	while(start < end) {
		char tmp = s[start];
		s[start] = s[end];
		s[end] = tmp;
		
		start++;
		end--;
	}
}

// Checks if the character is one of A-Z, uppercase
char is_alpha(char c) {
	return c >= 0x41 && c <= 0x5A;
}
//Sleeps for approximately sec seconds
void ugly_sleep(int ms) {
	int i = 0;
	int limit = 100000 * ms;
	while(i < limit) {
		i += 1;
	}
	i = i;
}
// Write to port
inline void outb(uint8_t val, uint16_t port) {
    asm volatile ( "outb %0, %1" : : "a"(val), "Nd"(port));
}

// Read from port
inline uint8_t inb(uint16_t port) {
	uint8_t ret;
	asm volatile ("inb %1, %0"
					: "=a"(ret)
                    : "Nd"(port)
				);
	return ret; 
}

// Returns the current interrupt flags
char cli() {
	uint16_t eflags;
	asm("pushf; pop %0" : "=a"(eflags));

	char int_enabled = (eflags >> 9) & 1;

	asm("cli");

	return int_enabled;
}

// Set the interrupt flag
void sti(char c) {
	if(c) // only if interrupts were on should we turn it on again
		asm("sti");
}

// Don't have malloc so won't implement this now
// char* strdup(const char* s) {
// 	size_t len = strlen(s);
// 	char* pt = malloc(sizeof(char) * (len + 1));
// 	memcpy(pt, s, len);
// }