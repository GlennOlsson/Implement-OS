#include <stdint-gcc.h>

#ifndef SERIAL_H
#define SERIAL_H

void SER_init();
int SER_write_c(char c);
int SER_write_str(const char* str);

void SER_interrupt();

char trigger_write();

#endif