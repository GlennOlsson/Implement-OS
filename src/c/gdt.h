#include <stdint-gcc.h>

#ifndef GDT_H
#define GDT_H

void setup_gdt();
void load_gdt();

// From gdt_loader.asm
extern void set_gdt(uint16_t size, uint64_t* address);
extern void reload_segments();

#endif