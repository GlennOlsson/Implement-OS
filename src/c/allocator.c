#include "allocator.h"
#include "page_table.h"
#include "memory_manager.h"
#include "vga_api.h"

#include <stdint-gcc.h>

#define nullptr 0
#define KMALLOC_HEADER_SIZE sizeof(struct KmallocExtra)

uint16_t curr_pf_index = 0;
void* curr_pf;

void MAL_init() {
    pool_64.max_size = 64;
    pool_64.avail = 0;
    pool_64.head = nullptr;
    
    pool_2048.max_size = 2048;
    pool_2048.avail = 0;
    pool_2048.head = nullptr;
}

void* kmalloc(uint32_t size) {
    uint32_t required_size = size + KMALLOC_HEADER_SIZE;

    struct KmallocPool* pool;
    if(required_size <= pool_64.max_size)
        pool = &pool_64;
    else
        pool = &pool_2048;
    
    printkln("Pool size %d required for malloc of %d bytes", pool->max_size, size);

    if(pool->avail == 0) { // allocate another page for it
        void* new_pf = MMU_alloc_page();

        void* prev_node = pool->head;
        for(int i = 0; i < PAGE_SIZE; i += pool->max_size) {
            void* address = new_pf + i;
            if(prev_node == nullptr) { // means head is nullptr
                pool->head = address;
                prev_node = address;
            }
            *(void**) prev_node = address;
            prev_node = address;
        }
    }

    void* prev_node = pool->head;
    while(prev_node != nullptr) {
        printkln("Node at %p, %p", prev_node, *(void**) prev_node);
        prev_node = *(void**) prev_node;
    }

    return pool->head;
}

void kfree(void *addr) {

}