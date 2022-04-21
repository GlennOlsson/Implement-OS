out_file = "/home/cpe454/Desktop/OS/src/asm/interrupt_init.asm"

isr_count = 256
content = """
; FILE GENERATED BY /home/cpe454/Desktop/OS/src/py/init_ints_generator.py
; ANY CHANGES TO THIS FILE WILL BE OVERWRITTEN BY THE SCRIPT

extern setup_idt
extern generic_interrupt_handler

global init_ints

"""

for i in range(256):
	content += f"global isr{i}\n"

content += """
section .text
init_ints:
	cli ; dissable interrupts

	call setup_idt ; Setup IDT in C

	lidt [RAX] ; return value from c
	
	; sti ; enable interrupts

	ret
"""

for i in range(256):
	code = f"""
isr{i}:
	; Push all register for safety
	push RBP
	push RBX
	push RSP
	push R12
	push R13
	push R14
	push R15
	push RAX
	push RCX
	push RDX
	push RSI
	push RDI
	push R8
	push R9
	push R10
	push R11

	mov	al, 0x20
	out	0x20, al
	
	mov RDI, {i} ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	; Pop in FILO order
	pop R11
	pop R10
	pop R9
	pop R8
	pop RDI
	pop RSI
	pop RDX
	pop RCX
	pop RAX
	pop R15
	pop R14
	pop R13
	pop R12
	pop RSP
	pop RBX
	pop RBP

	iretq
"""
	content += code

with open(out_file, "w") as f:
	f.write(content)