out_file = "/home/cpe454/Desktop/OS/src/asm/interrupt_init.asm"

isr_count = 256
content = """extern setup_idt
extern generic_interrupt_handler
global init_ints

"""

for i in range(256):
	content += f"global isr{i}\n"

content += """

init_ints:
	cli ; dissable interrupts


	; TODO: Remap PIC
	; TODO: Create global IDT (in C?)

	mov RDI, [isr0] ; Load first isr address into 1st arg
	call setup_idt ; Setup IDT in C

	lidt [RAX]

	;sti ; TODO: enable interrupts

	ret
"""

for i in range(256):
	code = f"""
isr{i}:
	push RAX
	push RBX

	mov RDI, {i} ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq
"""
	content += code

with open(out_file, "w") as f:
	f.write(content)