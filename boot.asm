global start

section .text
bits 32
start:
    ; print `OK` to screen
    mov dword [0xb8000], 0x2f6f2f47
    hlt


