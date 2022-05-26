#include "allocator.h"
#include "page_table.h"
#include "memory_manager.h"
#include "vga_api.h"

#include <stdint-gcc.h>

#define nullptr 0
#define KMALLOC_HEADER_SIZE sizeof(struct KmallocHeader)

/**
 * When allocating s bytes, we first look at the available pools
 * We pick the smallest pool that can fit s + KMALLOC_HEADER_SIZE, 
 *  eg pool_64 if s = 30 and KMALLOC_HEADER_SIZE = 12
 * 
 * We then look at the head in the pool. If this pointer is nullptr, it means
 *  that the pool has no free pages so we must allocate it
 * 
 * When we are sure that there is at least one block free in the pool, we pop the
 *  head of the pool, create a malloc header containing the size and pool address. 
 *  The pool address is used to return the block to the available blocks of pool
 *  when the address is freed. The size is really only used if there is no pool
 *  big enough to fit s + KMALLOC_HEADER_SIZE bytes. The page address (returned
 *  by the MMU_alloc() func) is then added with KMALLOC_HEADER_SIZE so that the 
 *  address returned to the user is where they can write. Otherwise the header would
 *  be overwritten
 * 
 * In the case were s + KMALLOC_HEADER_SIZE is bigger than any pool's block size,
 *  the allocator simply allocates enough pages from the MMU to fit all the bytes, 
 *  and returns the first page address (the rest will be consecutive as the MMU always
 *  returns consecutive addresses). When freed, the pages are also freed in the MMU
 *  as there is to pool to save them in
 * 
*/

struct KmallocPool pool_64 = {64, 0, 0};
struct KmallocPool pool_512 = {512, 0, 0};
struct KmallocPool pool_2048 = {2048, 0, 0};

// To introduce more pools, simply create one above and add it a the appropriate spot in the list below
// Make sure the list is sorted and that nullptr is in the end
struct KmallocPool* pools[] = {&pool_64, &pool_512, &pool_2048, nullptr};

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
    uint32_t required_size = size + KMALLOC_HEADER_SIZE;

    uint32_t index = 0;
    struct KmallocPool* pool = pools[index++];
    while (pool != nullptr && required_size > pool->block_size) {
        pool = pools[index++];
    }
    if(pool == nullptr) // required size is bigger than biggest pool, needs actual pages
        return kmalloc_big(size);
    
    // if here means pool != nullptr but !(required_size > pool->block_size)
    // i.e. required_size <= pool->block_size, use this pool!

    printkln("Using pool size %d for kmalloc(%d)", pool->block_size, size);

    if(pool->head == nullptr) { // allocate another page for it
        printkln("Need to allocate");
        allocate_for_pool(pool);
        return kmalloc(size); // Try again with newly allocated page
    }

    // take the first block of the pool
    void* address = pool->head;
    pool->head = *(void**) address;

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
    }
}
