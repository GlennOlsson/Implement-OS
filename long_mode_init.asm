global long_mode_start
extern kmain

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
    mov qword [0xb80a0], rax
    
 	mov rax, 0x2f212f532f4f2f6e
    mov qword [0xb80a8], rax

	mov rax, 0x2f212f532f070000
    mov qword [0xb80b0], rax

	call kmain

	hlt
