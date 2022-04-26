#include <stdint-gcc.h>

#ifndef BUFFER_H
#define BUFFER_H

#define BUFFER_SIZE 33 // Can store 1 less than this

struct Buffer {
	char buff[BUFFER_SIZE];
	int prod_index, cons_index;
	void (*consume_func)(char);
};

void BUF_init(struct Buffer* this, void (*consume_func)(char));
void BUF_consume(struct Buffer* this);
void BUF_produce(struct Buffer* this, char byte);

uint8_t BUF_consumeable(struct Buffer* this);
uint8_t BUF_produceable(struct Buffer* this);

#endif