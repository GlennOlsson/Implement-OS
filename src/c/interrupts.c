#include "interrupts.h"
#include "vga_api.h"
#include "stdint-gcc.h"
#include "lib.h"
#include "isr.h"

#define PIC1			0x20		/* IO base address for master PIC */
#define PIC2			0xA0		/* IO base address for slave PIC */
#define PIC1_COMMAND	PIC1
#define PIC1_DATA		(PIC1+1)
#define PIC2_COMMAND	PIC2
#define PIC2_DATA		(PIC2+1)

#define ICW1_ICW4		0x01		/* ICW4 (not) needed */
#define ICW1_INIT		0x10		/* Initialization - required! */
 
#define ICW4_8086		0x01		/* 8086/88 (MCS-80/85) mode */

static struct idt_t {
	uint16_t target_offset_1;

	uint16_t target_selector;

	uint16_t ist: 3;
	uint16_t res1: 5;
	uint16_t gate_type: 4;
	uint16_t zero: 1;
	uint16_t dpl: 2;
	uint16_t present: 1;

	uint16_t target_offset_2;
	uint32_t target_offset_3;

	uint32_t res2;	
} __attribute__((packed)) interrupt_desc_table[256];

static struct {
	uint16_t size;
	uint64_t idt_address;
} __attribute__((packed)) load_idt_struct;

void IRQ_set_mask(unsigned char irq_num) {
    uint16_t port;
 
    if(irq_num < 8)
        port = PIC1_DATA;
    else {
        port = PIC2_DATA;
        irq_num -= 8;
    }
	uint8_t curr_val = inb(port);
    uint8_t val = curr_val | (1 << irq_num);
    outb(val, port);
}
 
void IRQ_clear_mask(unsigned char irq_num) {
    uint16_t port;

    if(irq_num < 8) {
        port = PIC1_DATA;
    } else {
        port = PIC2_DATA;
        irq_num -= 8;
    }
	uint8_t curr_val = inb(port);
    uint8_t val = curr_val & ~(1 << irq_num);
    outb(val, port);        
}

int IRQ_get_mask(int irq_num) {
	uint16_t port;

	if(irq_num < 8)
        port = PIC1_DATA;
    else {
        port = PIC2_DATA;
        irq_num -= 8;
    }

	uint8_t full_mask = inb(port);
    int irq_num_mask = (full_mask >> irq_num) & 1;
	
	return irq_num_mask;
}

uint16_t IRQ_get_full_mask() {
	uint8_t pic1_mask = inb(PIC1_DATA);
	uint8_t pic2_mask = inb(PIC1_DATA);
	uint16_t full_mask = (pic1_mask << 8) | pic2_mask;

	return full_mask;
}

void IRQ_end_of_interrupt(int irq) {
	// ACK interrupt
	outb(0x20, irq < 8 ? PIC1_DATA : PIC2_DATA);
}

void map_PIC() {
	// save masks
	unsigned char a1 = inb(PIC1_DATA);
	unsigned char a2 = inb(PIC2_DATA);
 
	// starts the initialization sequence (in cascade mode)
	outb(ICW1_INIT | ICW1_ICW4, PIC1_COMMAND);
	outb(ICW1_INIT | ICW1_ICW4, PIC2_COMMAND);
	
	// Offset PIC1 to 0x20 and PIC2 to 0x28
	outb(0x20, PIC1_DATA);
	outb(0x28, PIC2_DATA);

	// ICW3: tell Master PIC that there is a slave PIC at IRQ2 (0000 0100)
	outb(4, PIC1_DATA);
	// ICW3: tell Slave PIC its cascade identity (0000 0010)
	outb(2, PIC2_DATA);

	outb(ICW4_8086, PIC1_DATA);
	outb(ICW4_8086, PIC2_DATA);
 
	// restore saved masks.
	outb(a1, PIC1_DATA);
	outb(a2, PIC2_DATA);
}

// Returns the address of the idt load struct
void* setup_idt() {
	map_PIC();

 	// Using GDT (0), privilige level == kernel (00)
	uint16_t segment_selector = 0b1000;

	int ist_index = 0;

	while(ist_index < 256) {
		int64_t ist_address = (uint64_t) isr_func_table[ist_index];

		int16_t offset_1 = ist_address & 0xFFFF;
		int16_t offset_2 = (ist_address >> 16) & 0xFFFF;
		int32_t offset_3 = (ist_address >> 32) & 0xFFFFFFFF;

		interrupt_desc_table[ist_index].target_offset_1 = offset_1;
		interrupt_desc_table[ist_index].target_offset_2 = offset_2;
		interrupt_desc_table[ist_index].target_offset_3 = offset_3;
		
		interrupt_desc_table[ist_index].target_selector = segment_selector;

		interrupt_desc_table[ist_index].ist = 0;
		interrupt_desc_table[ist_index].present = 1;
		interrupt_desc_table[ist_index].zero = 0;
		interrupt_desc_table[ist_index].gate_type = 0xE; // Interrup gate, disables intrerupt when they occur
		interrupt_desc_table[ist_index].dpl = 0x0; // Kernel privilege

		++ist_index;
	}

	load_idt_struct.idt_address = (uint64_t) interrupt_desc_table;
	load_idt_struct.size = (256 * 16) - 1; // 256 entries with 16 bytes a piece. -1 for convention

	return &load_idt_struct;
}

void generic_interrupt_handler(unsigned int isr_code, int error_code, void* arg) {

	// Vectors: http://www.brokenthorn.com/Resources/OSDevPic.html 

	if(isr_code > 255) { // can't be negative as unsigned
		printkln("INTERRUPT WITH BAD CODE: %d", isr_code);
	} else {
		// handle specific isr_codes and call their function, or perform generic action
		switch (isr_code) {
		case 0: 
			printkln("Divide by 0, error code: %d", error_code);
			break;
			
		case 1: 
			printkln("Single step (Debugger), error code: %d", error_code);
			break;
			
		case 2: 
			printkln("Non Maskable Interrupt (NMI) Pin, error code: %d", error_code);
			break;
			
		case 3: 
			printkln("Breakpoint (Debugger), error code: %d", error_code);
			break;
			
		case 4: 
			printkln("Overflow, error code: %d", error_code);
			break;
			
		case 5: 
			printkln("Bounds check, error code: %d", error_code);
			break;
			
		case 6: 
			printkln("Undefined Operation Code (OPCode) instruction, error code: %d", error_code);
			break;
			
		case 7: 
			printkln("No coprocessor, error code: %d", error_code);
			break;
			
		case 8: 
			printkln("Double Fault, error code: %d", error_code);
			break;
			
		case 9: 
			printkln("Coprocessor Segment Overrun, error code: %d", error_code);
			break;
			
		case 10: 
			printkln("Invalid Task State Segment (TSS), error code: %d", error_code);
			break;
			
		case 11: 
			printkln("Segment Not Present, error code: %d", error_code);
			break;
			
		case 12: 
			printkln("Stack Segment Overrun, error code: %d", error_code);
			break;
			
		case 13: 
			printkln("General Protection Fault (GPF), error code: %d", error_code);
			break;
			
		case 14: 
			printkln("Page Fault, error code: %d", error_code);
			break;
			
		case 15: 
			printkln("Unassigned, error code: %d", error_code);
			break;
			
		case 16: 
			printkln("Coprocessor error, error code: %d", error_code);
			break;
			
		case 17: 
			printkln("Alignment Check (486+ Only), error code: %d", error_code);
			break;
			
		case 18: 
			printkln("Machine Check (Pentium/586+ Only), error code: %d", error_code);
			break;

		default: // Generic action for unhandeled ISRs
			printkln("Unhandeled interrupt. ISR Code: %d, error code: %d", isr_code, error_code);;
			break;
		}
	}

	// outb(0x20, 0x20);
	// outb(0x20, 0xA0);
}