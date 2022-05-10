#include "interrupts.h"
#include "vga_api.h"
#include "stdint-gcc.h"
#include "lib.h"
#include "isr.h"
#include "ps2.h"
#include "serial.h"

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
	outb(0x20, PIC1);
	if(irq > 8)
		outb(0x20, PIC2);
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

 	// Using GDT (0), privilige level == kernel (00), index == 1 (or 8 really, offset)
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
		// if(ist_index == 8) // Double Fault #DF
		// 	interrupt_desc_table[ist_index].ist = 1;
		if(ist_index == 13) // General protection #GP
			interrupt_desc_table[ist_index].ist = 1;
		// if(ist_index == 14) // Page fault #PF
		// 	interrupt_desc_table[ist_index].ist = 1;

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

extern void read_cr2(uint64_t);

void generic_interrupt_handler(unsigned int isr_code, int error_code, void* arg) {
	char int_flag = cli();
	// Vectors: http://www.brokenthorn.com/Resources/OSDevPic.html 

	// Could use a list with function pointers instead, but to init that list we would to similar things to below

	uint64_t cr2_content = 0;

	if(isr_code > 255) { // can't be negative as unsigned
		printkln("INTERRUPT WITH BAD CODE: %d", isr_code);
	} else {
		// handle specific isr_codes and call their function, or perform generic action
		switch (isr_code) {
		// Reserved ISRs from IVT
		case 0: 
			printkln("Divide by 0");
			break;
			
		case 1: 
			printkln("Single step (Debugger)");
			break;
			
		case 2: 
			printkln("Non Maskable Interrupt (NMI) Pin");
			break;
			
		case 3: 
			printkln("Breakpoint (Debugger)");
			break;
			
		case 4: 
			printkln("Overflow");
			break;
			
		case 5: 
			printkln("Bounds check");
			break;
			
		case 6: 
			printkln("Undefined Operation Code (OPCode) instruction");
			break;
			
		case 7: 
			printkln("No coprocessor");
			break;
			
		case 8: 
			printkln("Double Fault");
			break;
			
		case 9: 
			printkln("Coprocessor Segment Overrun");
			break;
			
		case 10: 
			printkln("Invalid Task State Segment #TS (TSS)");
			break;
			
		case 11: 
			printkln("Segment Not Present");
			break;
			
		case 12: 
			printkln("Stack Segment Overrun");
			break;
			
		case 13: 
			//read_cr2(cr2_content);
			printkln("General Protection Fault (GPF), error code: %x", error_code);
			ugly_sleep(4000);
			break;
			
		case 14:
			read_cr2(cr2_content);
			printkln("Page Fault, error code: %x. CR2: %lx", error_code, cr2_content);
			ugly_sleep(5000);
			break;
			
		case 15: 
			printkln("Unassigned");
			break;
			
		case 16: 
			printkln("Coprocessor error");
			break;
			
		case 17: 
			printkln("Alignment Check (486+ Only)");
			break;
			
		case 18: 
			printkln("Machine Check (Pentium/586+ Only)");
			break;
			
		// IRQ interrupts
		case 32:
			printkln("IRQ Interrupt: Timer");
			IRQ_end_of_interrupt(0);
			break;
			
		case 33: // Keyboard
			PS2_keyboard_interrupt();
			IRQ_end_of_interrupt(1);
			break;
			
		case 34:
			printkln("IRQ Interrupt: Cascade for 8259A Slave controller");
			IRQ_end_of_interrupt(2);
			break;
			
		case 35:
			printkln("IRQ Interrupt: Serial port 2");
			IRQ_end_of_interrupt(3);
			break;
			
		case 36:
			SER_interrupt();

			IRQ_end_of_interrupt(4);
			break;
			
		case 37:
			printkln("IRQ Interrupt: AT systems: Parallel Port 2. PS/2 systems: reserved");
			IRQ_end_of_interrupt(5);
			break;
			
		case 38:
			printkln("IRQ Interrupt: Diskette drive");
			IRQ_end_of_interrupt(6);
			break;
			
		case 39:
			printkln("IRQ Interrupt: Parallel Port 1");
			IRQ_end_of_interrupt(7);
			break;
			
		case 40:
			printkln("IRQ Interrupt: CMOS Real time clock");
			IRQ_end_of_interrupt(8);
			break;
			
		case 41:
			printkln("IRQ Interrupt: CGA vertical retrace");
			IRQ_end_of_interrupt(9);
			break;
			
		case 42:
			printkln("IRQ Interrupt: Reserved");
			IRQ_end_of_interrupt(10);
			break;
			
		case 43:
			printkln("IRQ Interrupt: Reserved");
			IRQ_end_of_interrupt(11);
			break;
			
		case 44:
			printkln("IRQ Interrupt: AT systems: reserved. PS/2: auxiliary device");
			IRQ_end_of_interrupt(12);
			break;
			
		case 45:
			printkln("IRQ Interrupt: FPU");
			IRQ_end_of_interrupt(13);
			break;
			
		case 46:
			printkln("IRQ Interrupt: Hard disk controller");
			IRQ_end_of_interrupt(14);
			break;
			
		case 47:
			printkln("IRQ Interrupt: Reserved");
			IRQ_end_of_interrupt(15);
			break;

		default: // Generic action for unhandeled ISRs
			printkln("Unhandeled interrupt. ISR Code: %d, error code: %d", isr_code, error_code);;
			break;
		}
	}
	sti(int_flag);
}