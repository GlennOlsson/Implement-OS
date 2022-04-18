out_file = "/home/cpe454/Desktop/OS/src/asm/interrupt_init.asm"

isr_count = 256
content = """extern setup_idt
extern generic_interrupt_handler
extern print_long_hex
extern ugly_sleep
extern VGA_display_char

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

	lidt [RAX]

	;mov RDI, 10000
	;call ugly_sleep
	
	sti ; TODO: enable interrupts

	ret
"""

for i in range(256):
	code = f"""
isr{i}:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, {i} ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq
"""
	content += code

# content += """
# section .rodata
# idt:
# .entries: equ $ - idt
# 	;isr0
# 	; Set 0-15 bits of isr0 to RCX
# 	;mov RAX, 0xFFFF
# 	;and RAX, isr0
# 	;mov RCX, RAX 

# 	dw isr0
# 	dw 0b1000

# 	; Set segment selector to RDX
# 	;mov RDX, (0b1000 << 16)
	
# 	; Combine both segment selector and 16 first bits of isr0
# 	;or RDX, RCX

# 	;dq RDX


#     ;dq (1<<43) | (1<<44) | (1<<47) | (1<<53) ; idt entry segment
# .pointer:
#     dw $ - idt - 1
#     dq idt


# """

with open(out_file, "w") as f:
	f.write(content)