global long_mode_start

extern MUL_parse
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

    mov [RDI], EBX ; Mov EBX into argument
    call MUL_parse

    call init_ints

	call kmain

	hlt
