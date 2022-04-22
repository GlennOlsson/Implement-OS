#include <stdint-gcc.h>

#ifndef INTERRUPTS_H
#define INTERRUPTS_H

void IRQ_set_mask(unsigned char irq_num);
void IRQ_clear_mask(unsigned char irq_num);
int IRQ_get_mask(int irq_num);
void IRQ_end_of_interrupt(int irq);
uint16_t IRQ_get_full_mask();

#endif