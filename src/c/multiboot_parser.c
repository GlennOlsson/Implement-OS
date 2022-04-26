#include "multiboot_parser.h"
#include "vga_api.h"

#include <stdint-gcc.h>

struct Header {
	uint32_t tag_size;
	uint32_t reserved;
} __attribute__((packed)) header;

void MUL_parse(struct Header* tag_header) {
	
	asm("mov %0, EBX":"=a"(tag_header));

	printkln("Tag size: %d, %x", tag_header->tag_size, tag_header->reserved);
}