#include "stddef.h"

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

// Reasoning in lib.c
// char *strdup(const char *s);

#endif