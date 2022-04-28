#include <stdint-gcc.h>

#ifndef MEMORY_MANAGER_H
#define MEMORY_MANAGER_H

void PRE_add_allocated_span(uint64_t new_address, uint64_t new_size);
void PRE_add_address_space(uint64_t, uint64_t);
void PRE_print();
void PRE_traverse();

void MEM_init();
void* MEM_pf_alloc();
void MEM_pf_free(void *pf);

#endif