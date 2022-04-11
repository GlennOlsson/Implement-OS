#include "ps2.h"
#include "stdint-gcc.h"
#include "vga_api.h"
#include "lib.h"

#define PS2_DATA_PORT 0x60
#define PS2_STATUS_REG 0x64
#define PS2_COMMAND_REG 0x64

// https://wiki.osdev.org/%228042%22_PS/2_Controller#Status_Register
// Packed bitfield struct
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

// Packed bitfield struct
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

uint8_t read_status() {
	return inb(PS2_STATUS_REG);
}

uint8_t read_data() {
	return inb(PS2_DATA_PORT);
}

void write_command(uint8_t command) {
	return outb(command, PS2_COMMAND_REG);
}

void write_data(uint8_t data) {
	return outb(data, PS2_DATA_PORT);
}


// Wait until we can write to data port
// void wait_for_write() {
// 	// printkln("Waiting to write...");
// 	uint8_t i_buf_val = ((inb(PS2_STATUS_REG) & 0b10) >> 1);
// 	while(i_buf_val == 1)
// 		i_buf_val = ((inb(PS2_STATUS_REG) & 0b10) >> 1);
	
// 	// printkln("Can write!");
// }

// Wait until we can read from data port
// void wait_for_read() {
// 	// printkln("Waiting to read...");
// 	uint8_t o_buf_val = inb(PS2_STATUS_REG) & 0b1;
// 	// printkln("output buf val: %b", inb(PS2_STATUS_REG));
// 	while(o_buf_val != 1) {
// 		o_buf_val = inb(PS2_STATUS_REG) & 0b1;
// 	}
// 	// printkln("Can read!");
// }

// Wait until we can write to data port
void wait_for_write() {
	uint8_t port_content = read_status();
	struct StatusRegister* sr = (struct StatusRegister*) &port_content;

	while(sr->i_buf_status == 1){
		port_content = read_status();
		sr = (struct StatusRegister*) &port_content;
	}
}

// Wait until we can read from data port
void wait_for_read() {
	uint8_t port_content = read_status();
	struct StatusRegister* sr = (struct StatusRegister*) &port_content;

	while(sr->o_buf_status != 1) {
		uint8_t port_content = read_status();
		sr = (struct StatusRegister*) &port_content;
	}
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

// Polls the keyboard for events. Actions are sent to the argument function
void poll_keyboard(void (*key_action_func)(unsigned char)) {
	while(1) {
		printkln("polling charcode ");

		wait_for_read();
		unsigned char scancode = read_data();

		key_action_func(scancode);
	}
}

// Returns a pointer to a function which polls the keyboard
void* setup_keyboard() {
	wait_for_write();
	write_command(0xAD);// Dissable port 1
	wait_for_write();
	write_command(0xA7);// Dissable port 2
	wait_for_write();
	write_command(0x20);// Read config

	wait_for_read();
	uint8_t c_b = read_data();
	struct ControllerByte* controller_b = (struct ControllerByte*) &c_b;

	controller_b->port_1_interrupt = 1;
	controller_b->port_2_interrupt = 0;
	controller_b->port_1_clock = 1;
	controller_b->port_2_clock = 0;

	printkln("Writing %b as controller config", c_b);
	
	wait_for_write();
	write_command(0x60);// Write config

	wait_for_write();
	write_data(c_b);

	wait_for_write();
	write_command(0xAA); // Send test start

	wait_for_read();
	uint8_t resp = read_data();
	if(resp != 0x55) {
		printkln("PS/2 test failed");
	}

	wait_for_write();
	write_command(0xAE);// Enable first port again

	// wait_for_write();
	// outb(0xAD, PS2_COMMAND_REG); // Dissable port 1
	// wait_for_write();
	// outb(0xA7, PS2_COMMAND_REG); // Dissable port 2
	// wait_for_write();
	// outb(0x20, PS2_COMMAND_REG); // Read config

	// wait_for_read();
	// uint8_t c_b = inb(PS2_DATA_PORT);
	// struct ControllerByte* controller_b = (struct ControllerByte*) &c_b;

	// controller_b->port_1_interrupt = 1;
	// controller_b->port_2_interrupt = 0;
	// controller_b->port_1_clock = 1;
	// controller_b->port_2_clock = 0;

	// printkln("Writing %b as controller config", c_b);
	
	// wait_for_write();
	// outb(0x60, PS2_COMMAND_REG); // Write config

	// wait_for_write();
	// outb(c_b, PS2_DATA_PORT);

	// wait_for_write();
	// outb(0xAA, PS2_COMMAND_REG);

	// wait_for_read();
	// printkln("Replied with %x", inb(PS2_DATA_PORT));

	// wait_for_write();
	// outb(0xAE, PS2_COMMAND_REG); // Enable first port again

	printkln("Configed PS/2");
	//PS/2 controller should be configed

	//Config keyboard
	
	wait_for_write();
	write_data(0xF0); // Prepare for setting scancode

	wait_for_read(); // Read ACK
	resp = read_data();
	printkln("Prepare scancode, ACK=%x", resp);

	wait_for_write();
	write_data(0x2); // Set keyboard scancodes

	wait_for_read(); // Read ack
	resp = read_data();
	printkln("Set scancode, ACK=%x", resp);

	// Enable keyboard
	wait_for_write();
	write_data(0xF4);

	wait_for_read();
	resp = read_data();
	printkln("Enable kboard, ACK=%x", resp);

	printkln("keyboard setup done");
	// ugly_sleep(5);


	//Check scancode set
	wait_for_write();
	write_data(0xF0);

	wait_for_read();
	resp = read_data();
	printkln("Scan code command, ACK=%x", resp);

	wait_for_write();
	write_data(0x0);

	wait_for_read();
	resp = read_data();
	printkln("Scan code read, ACK=%x", resp);

	wait_for_read();
	resp = read_data();
	printkln("Scan code value, set=%x", resp);

	// ugly_sleep(5);


	// wait_for_write();
	// outb(0xEE, PS2_DATA_PORT); // Send echo command

	// wait_for_read();
	// printkln("EE response: %x", inb(PS2_DATA_PORT));

	// wait_for_write();
	// outb(0xF0, PS2_DATA_PORT);

	// wait_for_read();
	// printkln("Reading setting to F0 (ack?): %x", inb(PS2_DATA_PORT));

	// wait_for_write();
	// outb(0x2, PS2_DATA_PORT); // Set keyboard scancodes

	// wait_for_read();
	// printkln("Setting keyset response (ack): %x", inb(PS2_DATA_PORT));

	// wait_for_write();
	// outb(0xF0, PS2_DATA_PORT);

	// wait_for_read();
	// printkln("Reading setting to F0 (ack?): %x", inb(PS2_DATA_PORT));
	
	// wait_for_write();
	// outb(0x0, PS2_DATA_PORT);

	// wait_for_read();
	// printkln("Reading keyset response 1 (ack): %x", inb(PS2_DATA_PORT));

	// wait_for_read();
	// printkln("Reading keyset response 2: %x", inb(PS2_DATA_PORT));

	// // Enable keyboard
	// wait_for_write();
	// outb(0xF4, PS2_DATA_PORT);

	// wait_for_read();
	// printkln("Enable keyboard (ack): %x", inb(PS2_DATA_PORT));

	// return &poll_keyboard;
	while(1) {
		printkln("polling charcode ");

		wait_for_read();
		// unsigned char scancode = inb(PS2_DATA_PORT);
		unsigned char scancode = read_data();

		printkln("SCancode %x", scancode);

		// key_action_func(scancode);
	}
}