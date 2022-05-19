#include "multiboot_parser.h"
#include "vga_api.h"
#include "memory_manager.h"

#include <stdint-gcc.h>

struct EXX_Regsiters {
	uint32_t eax;
	uint32_t ebx;
} __attribute__((packed));

extern uint64_t save_exx;

struct Header {
	uint32_t total_size;
	uint32_t reserved;
} __attribute__((packed));

struct Tag {
	uint32_t tag_type;
	uint32_t tag_size;
} __attribute__((packed));

void next_tag(int bytes_consumed, uint32_t* start, struct Tag** tag) {
	uint8_t* ptr = (uint8_t*) start;

	ptr += bytes_consumed;

	*tag = (struct Tag*) ptr;
}

// Padd so it is divisible by 8
int padd_8(int val) {
	if(val % 8 == 0)
		return val;
	return val + (8 - (val % 8));
}

void _print_str(uint32_t size, char* str) {
	uint32_t index = 0;
	while(index < size) {
		char c = str[index++];
		VGA_print_char(c);
	}
}

void parse_cmd(uint32_t size, uint32_t* ptr) {
	char* str = (char*) ptr;

	printk("Boot cmd line: ");
	_print_str(size, str);
	VGA_print_char('\n');
}

void parse_boot_name(uint32_t size, uint32_t* ptr) {
	char* str = (char*) ptr;

	printk("Boot loader name: ");
	_print_str(size, str);
	VGA_print_char('\n');
}

void parse_mem_map(uint32_t size, uint32_t* ptr) {
	uint32_t entry_size = *ptr++;
	if(entry_size != 24) {
		printkln("MUL: Size %d not supported as Memory Map Entry Size", entry_size);
		return;
	}
	uint32_t entry_version = *ptr++;
	if(entry_version != 0) {
		printkln("MUL: Version %d not supported as Memory Map Entry Version", entry_version);
		return;
	}

	int consumed_bytes = 8; // the bytes from size and version above
	while(consumed_bytes < size) {
		uint64_t start_add = *((uint64_t*) ptr);
		ptr += 2; // 2 * 32 bit
		uint64_t length = *((uint64_t*) ptr);
		ptr += 2;
		uint32_t type = *ptr;
		ptr += 2; // For type and 4 bytes of reserved
		
		// Only care about type==1
		// printkln("Memory map, type: %d, start: %lx, length: %ld", type, start_add, length);
		if(type == 1) {
			PRE_add_address_space(start_add, length);
		}

		// Last uint32 is reserved so don't read it, but add it to consumed
		consumed_bytes += (sizeof(uint64_t) * 2) + (sizeof(uint32_t) * 2);
	}
}

void parse_elf(uint32_t size, uint32_t* ptr) {
	uint32_t entries = *ptr++;
	uint32_t h_size = *ptr++;

	ptr += 1; // Skip one attribute

	if(h_size != 64) { // 64 is total bytes required for entry
		printkln("MUL: ELF Header size %d not supported", h_size);
		return;
	}

	for(int i = 0; i < entries; ++i) {
		ptr += 4; // 2 * 4 + 1 * 8 bytes of other attributes
		uint64_t seg_addy = *((uint64_t*) ptr);
		
		ptr += 4;
		uint64_t seg_size = *((uint64_t*) ptr);

		ptr += 8;
		PRE_add_allocated_span(seg_addy, seg_size);
	}
}

void parse_tag(uint32_t tag_type, void (*parser)(uint32_t, uint32_t*)) {
	struct EXX_Regsiters* exx = (struct EXX_Regsiters*) &save_exx;

	if(exx->eax != 0x36d76289) {
		printkln("EAX does not contain magic value, is %x", exx->eax);
		return;
	}

	uint32_t* header_start = (uint32_t*) (uint64_t) exx->ebx;

	struct Header* tag_header = (struct Header*) header_start;

	int consumed_bytes = 8; // consumed the size field and the reserved bytes
	struct Tag* tag;
	while(consumed_bytes < tag_header->total_size) {
		// Function that calculates header address
		next_tag(consumed_bytes, header_start, &tag);

		// +1 so we consume the bytes of the tag's size and type
		uint32_t* data_start = (uint32_t*) (tag + 1);

		//printkln("Tag: %d, size: %d", tag->tag_type, tag->tag_size);
		if(tag->tag_type == tag_type) {
			parser(tag->tag_size - 8, data_start);
		}

		consumed_bytes += padd_8(tag->tag_size);
	}
}

void MUL_parse() {
	//parse_tag(1, &parse_cmd);
	//parse_tag(2, &parse_boot_name);

	// Make sure to parse ELF before mem-map
	parse_tag(9, &parse_elf);
	parse_tag(6, &parse_mem_map);
}