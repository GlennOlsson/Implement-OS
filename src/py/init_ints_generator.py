out_file = "/home/cpe454/Desktop/OS/src/asm/interrupt_init.asm"

error_code_isrs = [8, 10, 11, 12, 13, 14, 17]

isr_count = 256
content = """
; FILE GENERATED BY /home/cpe454/Desktop/OS/src/py/init_ints_generator.py
; ANY CHANGES TO THIS FILE WILL BE OVERWRITTEN BY THE SCRIPT

extern setup_idt
extern generic_interrupt_handler

extern VGA_print_long_hex
extern VGA_display_char

global init_ints

"""

for i in range(256):
	content += f"global isr{i}\n"

content += """
section .bss
align 8
curr_isr:
.after_push:
	resb 8
.after_pop:
	resb 8

error_code:
	resb 8

section .text
init_ints:
	cli ; dissable interrupts

	call setup_idt ; Setup IDT in C

	lidt [RAX] ; return value from c

	; enable interrupts in kmain

	ret

push_reg: ; Push all registers
	push RSI
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
	push RDI
	push R8
	push R9
	push R10
	push R11 ; 16 8-byte registers

	jmp [curr_isr.after_push]

pop_reg: ; Pop in FILO order
	pop R11
	pop R10
	pop R9
	pop R8
	pop RDI
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
	pop RSI

	jmp [curr_isr.after_pop]
"""

# Only add to isr's with error code
load_error_code = """
	mov RSI, [RSP + 8 * 16]
"""

reset_rsp_code = """
	add RSP, 8
"""

for i in range(256):
	code = f"""
isr{i}:

	; register jump-back instructions
	mov qword [curr_isr.after_push], isr{i}.after_push
	mov qword [curr_isr.after_pop], isr{i}.after_pop

	; Push all register for safety
	jmp push_reg

.after_push:

	{load_error_code if i in error_code_isrs else ""}

	mov RDI, {i} ; irq number, 1st arg
	;mov RSI, [RSP]

	call generic_interrupt_handler 

	; pop registers
	jmp pop_reg
.after_pop:

	{reset_rsp_code if i in error_code_isrs else ""}
	
	iretq
"""
	content += code

with open(out_file, "w") as f:
	f.write(content)