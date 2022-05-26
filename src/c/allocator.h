#ifndef ALLOCATOR_H
#define ALLOCATOR_H

#include <stdint-gcc.h>

struct KmallocPool {
   int max_size;
   int avail;
   struct FreeList *head;
} __attribute__((packed));

struct FreeList {
   struct FreeList *next;
} __attribute__((packed));

struct KmallocHeader { // 8 + 4 = 12 bytes
   struct KmallocPool *pool;
   int size;
} __attribute__((packed));

struct KmallocPool pool_64;
struct KmallocPool pool_2048;

void MAL_init();

void* kmalloc(uint32_t size);
void kfree(void *addr);

#endif