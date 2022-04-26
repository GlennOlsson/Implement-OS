#include "ps2.h"
#include "stdint-gcc.h"
#include "vga_api.h"
#include "lib.h"
#include "console.h"

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
}__attribute__((packed));

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
}__attribute__((packed));

uint8_t read_status() {
	return inb(PS2_STATUS_REG);
}

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

uint8_t read_data() {
	wait_for_read();
	return inb(PS2_DATA_PORT);
}

void write_command(uint8_t command) {
	wait_for_write();
	return outb(command, PS2_COMMAND_REG);
}

void write_data(uint8_t data) {
	wait_for_write();
	return outb(data, PS2_DATA_PORT);
}

void PS2_keyboard_interrupt() {
	uint8_t scancode = read_data();

	CON_key_action(scancode);
}

// Polls the keyboard for events. Actions are sent to the argument function
void poll_keyboard(void (*key_action_func)(unsigned char)) {
	while(1) {
		unsigned char scancode = read_data();

		key_action_func(scancode);
	}
}

// Returns a pointer to a function which polls the keyboard
void PS2_setup_keyboard() {
	write_command(0xAD);// Dissable port 1
	write_command(0xA7);// Dissable port 2
	write_command(0x20);// Read config

	uint8_t c_b = read_data();
	struct ControllerByte* controller_b = (struct ControllerByte*) &c_b;

	controller_b->port_1_interrupt = 1;
	controller_b->port_2_interrupt = 0;
	controller_b->port_1_clock = 1;
	controller_b->port_2_clock = 0;
	
	write_command(0x60);// Write config command

	write_data(c_b); // Write config

	write_command(0xAA); // Send test start

	uint8_t resp = read_data();
	if(resp != 0x55) {
		printkln("PS/2 test failed");
	}

	write_command(0xAE);// Enable first port again

	printkln("Configed PS/2");
	//PS/2 controller should be configed

	//Config keyboard
	write_data(0xF0); // Prepare for setting scancode

	write_data(0x2); // Set keyboard scancodes

	// Enable keyboard
	write_data(0xF4);

	printkln("keyboard setup done");

	//Check scancode set
	write_data(0xF0);

	write_data(0x0);

	return;
}