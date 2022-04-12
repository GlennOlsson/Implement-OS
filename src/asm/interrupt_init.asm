global init_ints

section .text
init_ints:
	mov rax, 0x2f6e2f652f6c2f47
    mov qword [0xb8000], rax
    
 	mov rax, 0x2f212f532f4f2f6e
    mov qword [0xb8008], rax