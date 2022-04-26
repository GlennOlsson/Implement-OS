#include "serial.h"
#include "lib.h"
#include "buffer.h"
#include "vga_api.h"

#include <stdint-gcc.h>

// https://www.lammertbies.nl/comm/info/serial-uart

#define COM1 0x3F8
#define COM1_RBR COM1 //receiver buffer	
#define COM1_THR COM1 //transmitter holding	
#define COM1_DLL COM1 //divisor latch LSB
#define COM1_DLL COM1 //divisor latch LSB
#define COM1_IER COM1+1 //interrupt enable	
#define COM1_DLM COM1+1 //divisor latch MSB
#define COM1_IIR COM1+2 //interrupt identification	
#define COM1_FCR COM1+2 //FIFO control
#define COM1_LCR COM1+3 //line control	
#define COM1_MCR COM1+4 //modem control
#define COM1_LSR COM1+5 //line status	
#define COM1_MSR COM1+6 //modem status	
#define COM1_SCR COM1+7 //scratch

struct Buffer serial_buffer;
// Waiting to write
char is_waiting = 0;

void DLAB_clear() {
	uint8_t lcr_val = inb(COM1_LCR);
	uint8_t mask = 0b01111111;
	uint8_t lcr_new = lcr_val & mask;
	outb(lcr_new, COM1_LCR);
}

void DLAB_set() {
	uint8_t lcr_val = inb(COM1_LCR);
	uint8_t mask = 0b10000000;
	uint8_t lcr_new = lcr_val | mask;
	outb(lcr_new, COM1_LCR);
}

// The speed, set as a divisor of 115 200
void set_baud(uint16_t divisor) {
	DLAB_set();

	uint8_t lower = divisor & 0xFFFF;
	uint8_t upper = (divisor >> 8) & 0xFFFF;

	// Least significant byte to DLL, most significant to DLM
	outb(lower, COM1_DLL);
	outb(upper, COM1_DLM);
	
	DLAB_clear();
}

void enable_interrupts() {
	uint8_t ier_val = inb(COM1_IER);
	ier_val |= 0b110; // enable "Transmitter holding register empty" and "Receiver line status register change"
	outb(ier_val, COM1_IER);
}

void write_to_serial(char c) {
	outb(c, COM1_THR);
}

char is_thr_empty() {
	char reg = inb(COM1_LSR);
	return (reg >> 5) & 1;
}

// Try to write from buffer
// Returns 1 if can write, 0 if not
char trigger_write() {
	char int_flag = cli();

	char ret_val;
	if(is_thr_empty() && BUF_consumeable(&serial_buffer)){ // If THR is empty and we have something to write
		is_waiting = 0;
		BUF_consume(&serial_buffer);
		ret_val = 1;
	} else if(!BUF_consumeable(&serial_buffer)) { // If empty
		is_waiting = 0;
		ret_val = 0;
	} else if(!is_thr_empty()) { // Buf is consumable but cannot write yet
		is_waiting = 1;
		ret_val = 0;
	}

	sti(int_flag);

	return ret_val;
}

void SER_init() {
	set_baud(4); // Some arbitrary value I guess, we don't want to high speed (i.e. not to low number)

	// Setting 8N1, 8 bits, no parity, 1 stop bit
	uint8_t line_ctr_val = 0b00000011;
	outb(line_ctr_val, COM1_LCR);

	BUF_init(&serial_buffer, &write_to_serial);

	outb(0, COM1_FCR);

	enable_interrupts();
}

// returns 1 if could be written or produced, 0 if buffer is full
int SER_write_c(char c) {
	char int_flag = cli();
	// If we can produce a value, do it. Else break loop because we rather
	// end the message early than supply it with missing bytes

	char ret_val = 0;

	/* If:
		- We are not waiting to write from buffer,
		- Buffer is empty, and,
		- THR is ready to receive data
		Write straight to serial
	*/
	if(!is_waiting && !BUF_consumeable(&serial_buffer) && is_thr_empty()) {
		write_to_serial(c);
		ret_val = 1;
	} // Else, see if buffer is availible and write to it
	else if(BUF_produceable(&serial_buffer)) {
		BUF_produce(&serial_buffer, c);
		ret_val = 1;
	}
	else{ // Else not produceable, i.e. don't write anything else. Rather short data than holes in it
		ret_val = 0;
	}

	sti(int_flag);
	return ret_val;
}

int SER_write_str(const char* str) {
	char int_flag = cli();

	int index = 0;
	char c = str[index++];
	while(c != '\0') {
		if(!SER_write_c(c)) // Break if could not write nor write to buffer
			break;

		c = str[index++];
	}

	sti(int_flag);

	return index;
}

void read_lsr() {
	uint8_t lsr = inb(COM1_LSR);
	if(lsr & 0b1) {
		printkln_no_serial("Data available");
	}
	if(lsr & 0b10) {
		printkln_no_serial("Overrun error");
	}
	if(lsr & 0b100) {
		printkln_no_serial("Parity error");
	}
	if(lsr & 0b1000) {
		printkln_no_serial("Framing error");
	}
	if(lsr & 0b10000) {
		printkln_no_serial("Break signal received");
	}
	if(lsr & 0b100000) {
		printkln_no_serial("THR is empty");
	}
	if(lsr & 0b1000000) {
		printkln_no_serial("THR is empty, and line is idle");
	}
	if(lsr & 0b10000000) {
		printkln_no_serial("Errornous data in FIFO");
	}
}

void SER_interrupt() {
	uint8_t iir = inb(COM1_IIR);
	if((iir >> 1) == 0b001) { // TX empty 
		trigger_write();
	} else if((iir >> 1) == 0b011) { // Line status change
		printkln_no_serial("Serial LINE interrupt");
		read_lsr();		
	} else {
		printkln_no_serial("Unsupported COM1 interrupt. IIR = %x", iir);
	}
}