global long_mode_start

extern init_ints
extern kmain

section .text
bits 64

long_mode_start:
    ; load 0 into all data segment registers
    mov AX, 0
    mov SS, AX
    mov DS, AX
    mov ES, AX
    mov FS, AX
    mov GS, AX

    call init_ints

	call kmain

	hlt
