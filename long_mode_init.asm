global long_mode_start

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

    ; print `OKAY` to screen
    mov rax, 0x2f6e2f652f6c2f47
    mov qword [0xb8000], rax
    
 	mov rax, 0x2f212f532f4f2f6e
    mov qword [0xb8008], rax
    
	hlt
