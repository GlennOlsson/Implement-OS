#include <stdint-gcc.h>

#ifndef SERIAL_H
#define SERIAL_H

void SER_init();
char SER_write_c(char c);
void SER_write_str(char* str);

void SER_interrupt();

#endif