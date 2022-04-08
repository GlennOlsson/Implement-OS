#include "ps2.h"
#include "stdint-gcc.h"
#include "vga_api.h"
#include "lib.h"

#define PS2_DATA_PORT 0x60
#define PS2_STATUS_REG 0x64
#define PS2_COMMAND_REG 0x64

// https://wiki.osdev.org/%228042%22_PS/2_Controller#Status_Register
struct StatusRegister {
	uint8_t o_buf_status: 1;
	uint8_t i_buf_status: 1;
	uint8_t sys_flag: 1;
	uint8_t command: 1; // 0 == sent from ps2 device, 1 == sent from controller
	uint8_t unknown_1: 1;
	uint8_t unknown_2: 1;
	uint8_t time_out_error: 1;
	uint8_t parity_error: 1;
};

struct ControllerByte {
	uint8_t port_1_interrupt: 1;
	uint8_t port_2_interrupt: 1;
	uint8_t sys_flag: 1;
	uint8_t zero1: 1;
	uint8_t port_1_clock: 1;
	uint8_t port_2_clock: 1;
	uint8_t port_1_translation: 1;
	uint8_t zero2: 1;
};

// Write to port
static inline void outb(uint8_t val, uint16_t port) {
    asm volatile ( "outb %0, %1" : : "a"(val), "Nd"(port));
}

// Read from port
static inline uint8_t inb(uint16_t port) {
	uint8_t ret;
	asm volatile ("inb %1, %0"
					: "=a"(ret)
                    : "Nd"(port)
				);
	return ret; 
}

// Wait until we can write to data port
void wait_for_write() {
	printkln("Waiting to write...");
	uint8_t i_buf_val = ((inb(PS2_STATUS_REG) & 0b10) >> 1);
	while(i_buf_val == 1)
		i_buf_val = ((inb(PS2_STATUS_REG) & 0b10) >> 1);
	
	printkln("Can write!");
}

// Wait until we can read from data port
void wait_for_read() {
	printkln("Waiting to read...");
	uint8_t o_buf_val = inb(PS2_STATUS_REG) & 0b1;
	printkln("output buf val: %b", inb(PS2_STATUS_REG));
	while(o_buf_val != 1) {
		o_buf_val = inb(PS2_STATUS_REG) & 0b1;
	}
	printkln("Can read!");
}


//Sleeps for approximately sec seconds
void ugly_sleep(int sec) {
	int i = 0;
	int limit = 100000000 * sec;
	while(i < limit) {
		i += 1;
	}
	i = i;
}

// MIGHT HAVE TO READ THE RESPONSE ALL THE TIME; SEEMS LIKE OT WONT UPDATE OTHWERWISE??
void setup_keyboard() {
	wait_for_write();
	outb(0xAD, PS2_COMMAND_REG); // Dissable port 1
	wait_for_write();
	outb(0xA7, PS2_COMMAND_REG); // Dissable port 2
	wait_for_write();
	outb(0x20, PS2_COMMAND_REG); // Read config

	wait_for_read();
	uint8_t c_b = inb(PS2_DATA_PORT);
	struct ControllerByte* controller_b = (struct ControllerByte*) &c_b;

	controller_b->port_1_interrupt = 1;
	controller_b->port_2_interrupt = 0;
	controller_b->port_1_clock = 1;
	controller_b->port_2_clock = 0;

	printkln("Writing %b as controller config", c_b);
	
	wait_for_write();
	outb(0x60, PS2_COMMAND_REG); // Write config

	wait_for_write();
	outb(c_b, PS2_DATA_PORT);

	wait_for_write();
	outb(0xAA, PS2_COMMAND_REG);

	wait_for_read();
	printkln("Replied with %x", inb(PS2_DATA_PORT));

	printkln("Configed PS/2");
	//PS/2 controller should be configed

	wait_for_write();
	outb(0xAE, PS2_COMMAND_REG); // Enable first port again

	//Config keyboard
	wait_for_write();
	outb(0xFF, PS2_DATA_PORT);

	wait_for_read();
	printkln("test response: %x", inb(PS2_DATA_PORT));


	wait_for_write();
	outb(0xEE, PS2_DATA_PORT);

	wait_for_read();
	printkln("EE response: %x", inb(PS2_DATA_PORT));

	wait_for_write();
	outb(0xF0, PS2_DATA_PORT);

	wait_for_read();
	printkln("F0 response: %x", inb(PS2_DATA_PORT));


	wait_for_write();
	outb(0x2, PS2_DATA_PORT);

	uint8_t s_r = inb(PS2_STATUS_REG);
	const struct StatusRegister* status_reg = (struct StatusRegister*) &s_r;
	
	wait_for_read();
	uint8_t data = inb(PS2_DATA_PORT);

	printkln("from device? %s. Data: %x. Status reg: %b", status_reg->command == 1 ? "no" : "yes", data, s_r);
}