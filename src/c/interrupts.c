#include "interrupts.h"
#include "vga_api.h"
#include "stdint-gcc.h"
#include "lib.h"

#define PIC1		0x20		/* IO base address for master PIC */
#define PIC2		0xA0		/* IO base address for slave PIC */
#define PIC1_COMMAND	PIC1
#define PIC1_DATA	(PIC1+1)
#define PIC2_COMMAND	PIC2
#define PIC2_DATA	(PIC2+1)

#define ICW1_ICW4	0x01		/* ICW4 (not) needed */
#define ICW1_SINGLE	0x02		/* Single (cascade) mode */
#define ICW1_INTERVAL4	0x04		/* Call address interval 4 (8) */
#define ICW1_LEVEL	0x08		/* Level triggered (edge) mode */
#define ICW1_INIT	0x10		/* Initialization - required! */
 
#define ICW4_8086	0x01		/* 8086/88 (MCS-80/85) mode */
#define ICW4_AUTO	0x02		/* Auto (normal) EOI */
#define ICW4_BUF_SLAVE	0x08		/* Buffered mode/slave */
#define ICW4_BUF_MASTER	0x0C		/* Buffered mode/master */
#define ICW4_SFNM	0x10		/* Special fully nested (not) */

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
	uint16_t size;
} load_idt_struct;

void map_PIC() {
	unsigned char a1 = inb(PIC1_DATA);                        // save masks
	unsigned char a2 = inb(PIC2_DATA);
 
	outb(PIC1_COMMAND, ICW1_INIT | ICW1_ICW4);  // starts the initialization sequence (in cascade mode)
	outb(PIC2_COMMAND, ICW1_INIT | ICW1_ICW4);
	outb(PIC1_DATA, 0x20);                 // ICW2: Master PIC vector offset
	outb(PIC2_DATA, 0x28);                 // ICW2: Slave PIC vector offset
	outb(PIC1_DATA, 4);                       // ICW3: tell Master PIC that there is a slave PIC at IRQ2 (0000 0100)
	outb(PIC2_DATA, 2);                       // ICW3: tell Slave PIC its cascade identity (0000 0010)
 
	outb(PIC1_DATA, ICW4_8086);
	outb(PIC2_DATA, ICW4_8086);
 
	outb(PIC1_DATA, a1);   // restore saved masks.
	outb(PIC2_DATA, a2);
}

// Returns the address of the idt load struct
void* setup_idt(int64_t first_ist_address, int64_t second_ist_address) {

	map_PIC();

	int ist_offset = second_ist_address - first_ist_address;
	int ist_index = 0;

	uint16_t segment_selector = 0b1000; // Using GDT (0), privilige level == kernel (00)

	printkln("First address: 0x%lx", first_ist_address);
	printkln("Secon address: 0x%lx", second_ist_address);
	printkln("Diff: 0x%x", ist_offset);

	while(ist_index < 256) {
		int64_t ist_address = first_ist_address; //+ (ist_index * ist_offset);

		int16_t offset_1 = ist_address & 0xFFFF;
		int16_t offset_2 = (ist_address >> 16) & 0xFFFF;
		int32_t offset_3 = (ist_address >> 32) & 0xFFFFFFFF;

		interrupt_desc_table[ist_index].target_offset_1 = offset_1;
		interrupt_desc_table[ist_index].target_offset_2 = offset_2;
		interrupt_desc_table[ist_index].target_offset_3 = offset_3;
		
		interrupt_desc_table[ist_index].target_selector = segment_selector;

		interrupt_desc_table[ist_index].present = 1;
		interrupt_desc_table[ist_index].zero = 0;
		interrupt_desc_table[ist_index].gate_type = 0xF;
		interrupt_desc_table[ist_index].dpl = 0x0; // Kernel privilege

		++ist_index;
		printkln("index %d has address %p", ist_index, (void*)ist_address);
		// ugly_sleep(1000);
	}

	load_idt_struct.idt_address = (uint64_t) interrupt_desc_table;
	load_idt_struct.size = 0x4000; // 0x4000 == 256 * 64, 64 bit per descriptor and 256 entries

	printkln("load idt at %p, first 64 bit: %lx, hoping to be %p, next 16 bits = %lx", &load_idt_struct, *((uint64_t*) &load_idt_struct), interrupt_desc_table, (*(((uint64_t*) &load_idt_struct) + 1)));

	print_long_hex((unsigned long) &load_idt_struct);
	print_char('\n');

	return &load_idt_struct;
}

void generic_interrupt_handler(int isr_code, int error_code, void* arg) {
	ugly_sleep(10000);

	printkln("Interrupt! Code=%d, error=%d, arg=%p", isr_code, error_code, arg);
	irq_table[0].handler(isr_code, error_code, arg); //TODO: Remove, just as to not get compile error
}