out_file = "/home/cpe454/Desktop/OS/src/asm/interrupt_init.asm"

isr_count = 256
content = """extern setup_idt
extern generic_interrupt_handler
extern print_long_hex
extern ugly_sleep

global init_ints

"""

for i in range(256):
	content += f"global isr{i}\n"

content += """
section .text
init_ints:
	cli ; dissable interrupts

	; TODO: Remap PIC
	; TODO: Create global IDT (in C?)

	mov RDI, [isr0] ; Load first isr address into 1st arg
	mov RSI, [isr1] ; Load code segment address into 2nd arg
	call setup_idt ; Setup IDT in C

	push RBP

	mov RBP, [RAX]
	mov RDI, [RAX]
	call print_long_hex


	lidt [RBP]

	pop RBP

	mov RDI, 2000
	call ugly_sleep
	
	sti ; TODO: enable interrupts

	ret
"""

for i in range(256):
	code = f"""
isr{i}:
	mov RDI, 10000
	call ugly_sleep

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