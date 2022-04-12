#include "interrupts.h"
#include "vga_api.h"

typedef void (*irq_handler_t)(int, int, void *);
static struct {
	void* arg;
	irq_handler_t handler;
} irq_table[255];

void generic_interrupt_handler(int isr_code, int error_code, void* arg) {
	printkln("Interrupt! Code=%d, error=%d, arg=%p", isr_code, error_code, arg);
	irq_table[0].handler(isr_code, error_code, arg); //TODO: Remove, just as to not get compile error
}