global long_mode_start
extern init_ints
extern kmain
extern print_char
extern print_long_hex

extern gdt64
extern gdt64.code_pointer

section .text
bits 64

long_mode_start:
    ; load 0 into all data segment registers
    mov ax, 0
    mov ss, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    call init_ints

    mov RDI, [gdt64.code_pointer]
    call print_long_hex ; gdt load entry (limit and address)

    mov RDI, 0xA
    call print_char

    mov RDI, gdt64
    call print_long_hex ; gdt address, found in above

    mov RDI, 0xA
    call print_char

    mov RDI, [gdt64]
    call print_long_hex ; gdt entry 1, just 0s

    mov RDI, 0xA
    call print_char

    mov RDI, [gdt64 + 8]
    call print_long_hex ; gdt entry 2, meaningful?

    mov RDI, 0xA
    call print_char

	call kmain

	hlt
