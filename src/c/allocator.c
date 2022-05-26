#include "allocator.h"
#include "page_table.h"
#include "memory_manager.h"
#include "vga_api.h"

#include <stdint-gcc.h>

#define nullptr 0
#define KMALLOC_HEADER_SIZE sizeof(struct KmallocHeader)

struct KmallocPool pool_64 = {64, 0, 0};
struct KmallocPool pool_2048 = {2048, 0, 0};
struct KmallocPool pool_512 = {512, 0, 0};

uint16_t curr_pf_index = 0;
void* curr_pf;

void allocate_for_pool(struct KmallocPool* pool) {
        void* new_pf = MMU_alloc_page();

        void* prev_node = pool->head;
        for(int i = 0; i < PAGE_SIZE; i += pool->block_size) {
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

// allocate potentially multiple consecutive pages
// Start address will be at first page
void* kmalloc_big(uint32_t size) {
    int required_size = size + KMALLOC_HEADER_SIZE;

    void* start = MMU_alloc_page();

    struct KmallocHeader header;
    header.pool = nullptr;
    header.size = size;

    *(struct KmallocHeader*) start = header;
    start += KMALLOC_HEADER_SIZE;

    uint32_t allocated_pages = 1;

    while(required_size > 0) {
        // Remove size of full page as it can be used if needed. If required_size is less than a page
        // it does not matter, will just mean that it's the last iteration
        required_size -= PAGE_SIZE;

        // only want the kmalloc header in the first page
        MMU_alloc_page();

        allocated_pages += 1;
    }

    printkln("Size %d requires %d pages", size, allocated_pages);

    return start;
}

void* kmalloc(uint32_t size) {
    struct KmallocPool* pool;

    uint32_t required_size = size + KMALLOC_HEADER_SIZE;
    if(required_size <= pool_64.block_size)
        pool = &pool_64;
    else if(required_size <= pool_512.block_size)
        pool = &pool_512;
    else if(required_size <= pool_2048.block_size)
        pool = &pool_2048;
    else // required size is bigger than biggest pool, needs actual pages
        return kmalloc_big(size);

    printkln("Using pool size %d for kmalloc(%d)", pool->block_size, size);

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

    return address;
}

// Actually free the virtual pages too, don't keep in a free list
// Address is of first page, i.e. start of header
void kfree_big(void* start_add, struct KmallocHeader* header) {
    void* address = start_add;
    int size = header->size;

    uint32_t freed_pages = 0;
    while(size > 0) {
        MMU_free_page(address);
        address += PAGE_SIZE;

        size -= PAGE_SIZE;

        freed_pages += 1;
    }

    printkln("Big free, %d pages", freed_pages);
}

void kfree(void* add) {
    void* start_address = add - KMALLOC_HEADER_SIZE;
    struct KmallocHeader* header = start_address;

    // If no pool, is a big allocation over potentially multiple pages
    if(header->pool == nullptr) {
        kfree_big(add, header);
        return;
    }
     
    // in case bigger than one pool block
    // can't be uint as we must see if it goes under 0
    int block_size = header->size;

    struct KmallocPool* pool = header->pool;

    struct FreeList* tail = traverse(pool);

    while(block_size > 0) {
        block_size -= pool->block_size;
        
        tail->next = start_address;
        tail->next->next = nullptr; // Set next of the block as nullptr
        pool->avail += 1;
    }
}