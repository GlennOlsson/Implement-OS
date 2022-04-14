#include "interrupts.h"
#include "vga_api.h"
#include "stdint-gcc.h"

typedef void (*irq_handler_t)(int, int, void *);
static struct {
	void* arg;
	irq_handler_t handler;
} irq_table[256];


static struct {
	uint16_t target_offset_1;

	uint16_t target_selector;

	uint8_t ist: 3;
	uint8_t res1: 5;
	uint8_t gate_type: 4;
	uint8_t zero: 1;
	uint8_t dpl: 2;
	uint8_t present: 1;

	uint16_t target_offset_2;
	uint32_t target_offset_3;

	uint32_t res2;	
} interrupt_desc_table[256];

static struct {
	uint64_t idt_address;
	// 0x4000 == 256 * 64, 64 bit per descriptor and 256 entries
	uint16_t size;
} load_idt_struct;

// Returns the address of the idt
void* setup_idt(int64_t first_ist_address) {
	int ist_offset = 0x1000000;
	int ist_index = 0;
	while(ist_index < 256) {
		int64_t ist_address = first_ist_address + (ist_index * ist_offset);

		int16_t offset_1 = ist_address & 0xFFFF;
		int16_t offset_2 = (ist_address >> 16) & 0xFFFF;
		int32_t offset_3 = (ist_address >> 32) & 0xFFFFFFFF;

		interrupt_desc_table[ist_index].target_offset_1 = offset_1;
		interrupt_desc_table[ist_index].target_offset_2 = offset_2;
		interrupt_desc_table[ist_index].target_offset_3 = offset_3;
		interrupt_desc_table[ist_index].present = 1;
		interrupt_desc_table[ist_index].gate_type = 0xF;
		interrupt_desc_table[ist_index].dpl = 0x0; // Kernel privilege

		++ist_index;
	}

	load_idt_struct.idt_address = (uint64_t) interrupt_desc_table;
	load_idt_struct.size = 0x4000;

	printkln("load idt at %p, idt at %p, val: %x, val2: %x, val3: %x", &load_idt_struct, interrupt_desc_table, *((uint32_t*) &load_idt_struct), *(((uint32_t*) &load_idt_struct) + 1), *(((uint32_t*) &load_idt_struct) + 2));

	return &load_idt_struct;
}

void generic_interrupt_handler(int isr_code, int error_code, void* arg) {
	printkln("Interrupt! Code=%d, error=%d, arg=%p", isr_code, error_code, arg);
	irq_table[0].handler(isr_code, error_code, arg); //TODO: Remove, just as to not get compile error
}