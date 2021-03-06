#include "stddef.h"
#include "stdint-gcc.h"

#ifndef LIB_H
#define LIB_H

void *memset(void *dst, int c, size_t n);
void *memcpy(void *dest, const void *src, size_t n);
size_t strlen(const char *s);
char *strcpy(char *dest, const char *src);
int strcmp(const char *s1, const char *s2);
const char *strchr(const char *s, int c);

void to_string(long i, char* s, long base);

char is_alpha(char c);

void ugly_sleep(int sec);

void outb(uint8_t val, uint16_t port);
uint8_t inb(uint16_t port);

// Returns the current interrupt flags
char cli();
// Set the interrupt flag
void sti(char);

// Reasoning in lib.c
// char *strdup(const char *s);

#endif