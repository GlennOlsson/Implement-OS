#include "allocator.h"
#include "page_table.h"
#include "memory_manager.h"
#include "vga_api.h"

#include <stdint-gcc.h>

#define nullptr 0
#define KMALLOC_HEADER_SIZE sizeof(struct KmallocHeader)

uint16_t curr_pf_index = 0;
void* curr_pf;

void MAL_init() {
    pool_64.max_size = 64 - KMALLOC_HEADER_SIZE;
    pool_64.avail = 0;
    pool_64.head = nullptr;
    
    pool_2048.max_size = 2048 - KMALLOC_HEADER_SIZE;
    pool_2048.avail = 0;
    pool_2048.head = nullptr;
}

void allocate_for_pool(struct KmallocPool* pool) {
        void* new_pf = MMU_alloc_page();

        void* prev_node = pool->head;
        for(int i = 0; i < PAGE_SIZE; i += (pool->max_size + KMALLOC_HEADER_SIZE)) {
            void* address = new_pf + i;
            if(prev_node == nullptr) { // means head is nullptr
                pool->head = address;
                prev_node = address;
                *(void**) prev_node = nullptr;
            } else // only write the address if prev_node is not the head. Head should point to nullptr
                *(void**) prev_node = address;
            prev_node = address;

            pool->avail += 1;
        }
}

// Traverse the free list of the pool and return the tail (not nullptr)
void* traverse(struct KmallocPool* pool) {
    struct FreeList* node = pool->head;
    while(node->next != nullptr)
        node = node->next;
    
    return node; // This node will be pointing to nullptr
}

void* kmalloc(uint32_t size) {
    struct KmallocPool* pool;
    if(size <= pool_64.max_size)
        pool = &pool_64;
    else
        pool = &pool_2048;
    
    printkln("Pool size %d required for malloc of %d bytes", pool->max_size, size);
    printkln("Using pool %p", pool);

    if(pool->avail == 0) { // allocate another page for it
        printkln("Need to allocate");
        allocate_for_pool(pool);
        return kmalloc(size); // Try again with newly allocated page
    }

    // take the first block of the pool
    void* address = pool->head;
    pool->head = *(void**) address;
    pool->avail -= 1;

    struct KmallocHeader header;
    header.pool = pool;
    header.size = size;

    *(struct KmallocHeader*) address = header;
    address += KMALLOC_HEADER_SIZE;

    printkln("Malloced %p, header at %p", address, (address - KMALLOC_HEADER_SIZE));

    return address;
}

void kfree(void *add) {
    void* start_address = add - KMALLOC_HEADER_SIZE;
    struct KmallocHeader* header = start_address;

    int block_size = header->size; // in case bigger than one pool block
    struct KmallocPool* pool = header->pool;

    struct FreeList* tail = traverse(pool);

    printkln("Block size: %d, pool add: %p, size: %d", block_size, pool, pool->max_size);
    while(block_size > 0) {
        printkln("Block size: %d", block_size);
        block_size -= pool->max_size;
        
        tail->next = start_address;
        tail->next->next = nullptr; // Set next of the block as nullptr
        pool->avail += 1;
    }
}