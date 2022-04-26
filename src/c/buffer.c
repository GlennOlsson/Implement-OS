#include "buffer.h"
#include "vga_api.h"

#include <stdint-gcc.h>

void BUF_init(struct Buffer* this, void (*consume_func)(char)) {
	this->prod_index = 0;
	this->cons_index = 0;
	this->consume_func = consume_func;
}

void BUF_consume(struct Buffer* this) {
	if(this->prod_index == this->cons_index) // If same, nothing to consume
		return;
	
	char byte = this->buff[this->cons_index++];
	this->consume_func(byte);

	if(this->cons_index >= BUFFER_SIZE)
		this->cons_index = 0;
}

void BUF_produce(struct Buffer* this, char byte) {
	if(this->prod_index == this->cons_index - 1 
		|| (this->prod_index == BUFFER_SIZE - 1 && this->cons_index == 0)) // If next spot is consumer ptr, buffer is full. Ignore
		return;
	
	this->buff[this->prod_index++] = byte;
	if(this->prod_index >= BUFFER_SIZE)
		this->prod_index = 0;
}

// How many bytes can be consumed from the buffer
uint8_t BUF_consumeable(struct Buffer* this) {
	//Special case
	if(this->prod_index == this->cons_index)
		return 0;

	if(this->prod_index > this->cons_index) {
		return this->prod_index - this->cons_index;
	} else {
		return BUFFER_SIZE - (this->cons_index - this->prod_index);
	}
}

// How many bytes can be added to the buffer
uint8_t BUF_produceable(struct Buffer* this) {
	// Special case when they are the same
	if(this->cons_index == this->prod_index)
		return BUFFER_SIZE - 1;

	uint8_t consumeable = BUF_consumeable(this);
	return BUFFER_SIZE - consumeable - 1; // Can store 1 less than the size in the buffer
}