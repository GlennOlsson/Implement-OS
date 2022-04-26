#include "multiboot_parser.h"
#include "vga_api.h"

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
		uint32_t type = *ptr++;
		
		// Only care about type==1
		if(type == 1) // TODO: Something meaningful with the info here
			printkln("Memory map. Start: %lx, length: %ld, type: %d", start_add, length, type);

		// Last uint32 is reserved so don't read it, but add it to consumed
		consumed_bytes += (sizeof(uint64_t) * 2) + (sizeof(uint32_t) * 2);
	}
}

void parse_elf(uint32_t* ptr) {
	uint32_t entries = *ptr++;
	uint32_t h_size = *ptr++;
	// uint32_t string_table_index = *ptr++;

	ptr += 1;

	if(h_size != 64) { // 64 is total bytes required for entry
		printkln("MUL: ELF Header size %d not supported", h_size);
		return;
	}

	uint64_t segments[entries * 2]; // first address followed by size
	for(int i = 0; i < entries * 2; ++i) { // make all = 0
		segments[i] = 0;
	}
	int curr_seg_index = 0;

	for(int i = 0; i < entries; ++i) {
		// uint32_t sec_name = *ptr++;
		// uint32_t type = *ptr++;

		ptr += 2;

		// uint64_t flags = *((uint64_t*) ptr);
		ptr += 2;
		uint64_t seg_addy = *((uint64_t*) ptr); // THIS
		ptr += 2;
		// uint64_t seg_offset = *((uint64_t*) ptr);
		ptr += 2;
		uint64_t seg_size = *((uint64_t*) ptr); // THIS
		ptr += 2;

		printkln("Add: %lx, Size: %lx. Last seg add: %lx, size: %lx", seg_addy, seg_size, segments[curr_seg_index], segments[curr_seg_index+1]);

		if(seg_size > 0) {
			// if first segment to add, or
			if(segments[curr_seg_index] == 0) {
				segments[curr_seg_index] = seg_addy;
				segments[curr_seg_index + 1] = seg_size;
			} else if(segments[curr_seg_index] + segments[curr_seg_index + 1] == seg_addy) {
				// if last start address plus that segment size == current address, add this segment space
				segments[curr_seg_index + 1] += seg_size;
			} else {
				printkln("Does not follow, diff: %ld", seg_addy - (segments[curr_seg_index] + segments[curr_seg_index + 1]));
				curr_seg_index += 2;
				segments[curr_seg_index] = seg_addy;
				segments[curr_seg_index + 1] = seg_size;
			}
		}

		// uint32_t table_index = *ptr++;
		// uint32_t ex_info = *ptr++;

		ptr += 2;

		// uint64_t add_alig = *((uint64_t*) ptr); // power of 2
		ptr += 2;
		// uint64_t fixed_entry_size = *((uint64_t*) ptr); // IFF section holds fixed entries
		ptr += 2;

		// printkln("ELF entry: seg_addy: %lx, seg_size: %lx", seg_addy, seg_size);
	}

	for(int i = 0; i < entries * 2; i += 2) {
		if(segments[i] == 0)
			break;
		printkln("From %lx to %lx", segments[i], segments[i] + segments[i+1]);
	}
}

void MUL_parse() {
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

		printkln("Tag: %d, size: %d", tag->tag_type, tag->tag_size);
		switch (tag->tag_type) {
		case 0:
			if(tag->tag_size != 8)
				printkln("MUL: Tag 0 but size is not 8");
			//Just break, type 0 means it terminates the tag list
			break;

		case 1:
			parse_cmd(tag->tag_size - 8, data_start);
			break;

		case 2:
			parse_boot_name(tag->tag_size - 8, data_start);
			break;
		
		case 6:
			parse_mem_map(tag->tag_size - 8, data_start);
			break;

		case 9:
			parse_elf(data_start);
			break;

		default: // Unhandled tags
			break;
		}

		consumed_bytes += padd_8(tag->tag_size);
	}
}