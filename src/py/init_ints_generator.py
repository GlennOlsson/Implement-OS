out_file = "/home/cpe454/Desktop/OS/src/asm/interrupt_init.asm"

isr_count = 256
content = """extern generic_interrupt_handler
global init_ints

init_ints:
	cli ; dissable interrupts

	; TODO: Remap PIC
	; TODO: Create global IDT (in C?)
	; ISR

	;sti ; TODO: enable interrupts

	ret
"""

for i in range(256):
	code = f"""
isr{i}:
	push RAX
	push RBX

	mov RDI, {i} ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq
"""
	content += code

with open(out_file, "w") as f:
	f.write(content)