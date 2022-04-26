#include <stdint-gcc.h>

#ifndef MEMORY_MANAGER_H
#define MEMORY_MANAGER_H

void PRE_add_span(uint64_t new_address, uint64_t new_size);
void PRE_print();

void MEM_init();

#endif