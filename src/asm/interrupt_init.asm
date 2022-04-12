extern generic_interrupt_handler
global init_ints

init_ints:
	cli ; dissable interrupts

	; TODO: Remap PIC
	; TODO: Create global IDT (in C?)
	; ISR

	;sti ; TODO: enable interrupts

	ret

isr0:
	push RAX
	push RBX

	mov RDI, 0 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr1:
	push RAX
	push RBX

	mov RDI, 1 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr2:
	push RAX
	push RBX

	mov RDI, 2 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr3:
	push RAX
	push RBX

	mov RDI, 3 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr4:
	push RAX
	push RBX

	mov RDI, 4 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr5:
	push RAX
	push RBX

	mov RDI, 5 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr6:
	push RAX
	push RBX

	mov RDI, 6 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr7:
	push RAX
	push RBX

	mov RDI, 7 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr8:
	push RAX
	push RBX

	mov RDI, 8 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr9:
	push RAX
	push RBX

	mov RDI, 9 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr10:
	push RAX
	push RBX

	mov RDI, 10 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr11:
	push RAX
	push RBX

	mov RDI, 11 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr12:
	push RAX
	push RBX

	mov RDI, 12 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr13:
	push RAX
	push RBX

	mov RDI, 13 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr14:
	push RAX
	push RBX

	mov RDI, 14 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr15:
	push RAX
	push RBX

	mov RDI, 15 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr16:
	push RAX
	push RBX

	mov RDI, 16 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr17:
	push RAX
	push RBX

	mov RDI, 17 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr18:
	push RAX
	push RBX

	mov RDI, 18 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr19:
	push RAX
	push RBX

	mov RDI, 19 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr20:
	push RAX
	push RBX

	mov RDI, 20 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr21:
	push RAX
	push RBX

	mov RDI, 21 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr22:
	push RAX
	push RBX

	mov RDI, 22 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr23:
	push RAX
	push RBX

	mov RDI, 23 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr24:
	push RAX
	push RBX

	mov RDI, 24 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr25:
	push RAX
	push RBX

	mov RDI, 25 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr26:
	push RAX
	push RBX

	mov RDI, 26 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr27:
	push RAX
	push RBX

	mov RDI, 27 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr28:
	push RAX
	push RBX

	mov RDI, 28 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr29:
	push RAX
	push RBX

	mov RDI, 29 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr30:
	push RAX
	push RBX

	mov RDI, 30 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr31:
	push RAX
	push RBX

	mov RDI, 31 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr32:
	push RAX
	push RBX

	mov RDI, 32 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr33:
	push RAX
	push RBX

	mov RDI, 33 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr34:
	push RAX
	push RBX

	mov RDI, 34 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr35:
	push RAX
	push RBX

	mov RDI, 35 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr36:
	push RAX
	push RBX

	mov RDI, 36 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr37:
	push RAX
	push RBX

	mov RDI, 37 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr38:
	push RAX
	push RBX

	mov RDI, 38 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr39:
	push RAX
	push RBX

	mov RDI, 39 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr40:
	push RAX
	push RBX

	mov RDI, 40 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr41:
	push RAX
	push RBX

	mov RDI, 41 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr42:
	push RAX
	push RBX

	mov RDI, 42 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr43:
	push RAX
	push RBX

	mov RDI, 43 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr44:
	push RAX
	push RBX

	mov RDI, 44 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr45:
	push RAX
	push RBX

	mov RDI, 45 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr46:
	push RAX
	push RBX

	mov RDI, 46 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr47:
	push RAX
	push RBX

	mov RDI, 47 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr48:
	push RAX
	push RBX

	mov RDI, 48 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr49:
	push RAX
	push RBX

	mov RDI, 49 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr50:
	push RAX
	push RBX

	mov RDI, 50 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr51:
	push RAX
	push RBX

	mov RDI, 51 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr52:
	push RAX
	push RBX

	mov RDI, 52 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr53:
	push RAX
	push RBX

	mov RDI, 53 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr54:
	push RAX
	push RBX

	mov RDI, 54 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr55:
	push RAX
	push RBX

	mov RDI, 55 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr56:
	push RAX
	push RBX

	mov RDI, 56 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr57:
	push RAX
	push RBX

	mov RDI, 57 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr58:
	push RAX
	push RBX

	mov RDI, 58 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr59:
	push RAX
	push RBX

	mov RDI, 59 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr60:
	push RAX
	push RBX

	mov RDI, 60 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr61:
	push RAX
	push RBX

	mov RDI, 61 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr62:
	push RAX
	push RBX

	mov RDI, 62 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr63:
	push RAX
	push RBX

	mov RDI, 63 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr64:
	push RAX
	push RBX

	mov RDI, 64 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr65:
	push RAX
	push RBX

	mov RDI, 65 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr66:
	push RAX
	push RBX

	mov RDI, 66 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr67:
	push RAX
	push RBX

	mov RDI, 67 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr68:
	push RAX
	push RBX

	mov RDI, 68 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr69:
	push RAX
	push RBX

	mov RDI, 69 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr70:
	push RAX
	push RBX

	mov RDI, 70 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr71:
	push RAX
	push RBX

	mov RDI, 71 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr72:
	push RAX
	push RBX

	mov RDI, 72 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr73:
	push RAX
	push RBX

	mov RDI, 73 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr74:
	push RAX
	push RBX

	mov RDI, 74 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr75:
	push RAX
	push RBX

	mov RDI, 75 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr76:
	push RAX
	push RBX

	mov RDI, 76 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr77:
	push RAX
	push RBX

	mov RDI, 77 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr78:
	push RAX
	push RBX

	mov RDI, 78 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr79:
	push RAX
	push RBX

	mov RDI, 79 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr80:
	push RAX
	push RBX

	mov RDI, 80 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr81:
	push RAX
	push RBX

	mov RDI, 81 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr82:
	push RAX
	push RBX

	mov RDI, 82 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr83:
	push RAX
	push RBX

	mov RDI, 83 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr84:
	push RAX
	push RBX

	mov RDI, 84 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr85:
	push RAX
	push RBX

	mov RDI, 85 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr86:
	push RAX
	push RBX

	mov RDI, 86 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr87:
	push RAX
	push RBX

	mov RDI, 87 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr88:
	push RAX
	push RBX

	mov RDI, 88 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr89:
	push RAX
	push RBX

	mov RDI, 89 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr90:
	push RAX
	push RBX

	mov RDI, 90 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr91:
	push RAX
	push RBX

	mov RDI, 91 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr92:
	push RAX
	push RBX

	mov RDI, 92 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr93:
	push RAX
	push RBX

	mov RDI, 93 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr94:
	push RAX
	push RBX

	mov RDI, 94 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr95:
	push RAX
	push RBX

	mov RDI, 95 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr96:
	push RAX
	push RBX

	mov RDI, 96 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr97:
	push RAX
	push RBX

	mov RDI, 97 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr98:
	push RAX
	push RBX

	mov RDI, 98 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr99:
	push RAX
	push RBX

	mov RDI, 99 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr100:
	push RAX
	push RBX

	mov RDI, 100 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr101:
	push RAX
	push RBX

	mov RDI, 101 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr102:
	push RAX
	push RBX

	mov RDI, 102 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr103:
	push RAX
	push RBX

	mov RDI, 103 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr104:
	push RAX
	push RBX

	mov RDI, 104 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr105:
	push RAX
	push RBX

	mov RDI, 105 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr106:
	push RAX
	push RBX

	mov RDI, 106 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr107:
	push RAX
	push RBX

	mov RDI, 107 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr108:
	push RAX
	push RBX

	mov RDI, 108 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr109:
	push RAX
	push RBX

	mov RDI, 109 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr110:
	push RAX
	push RBX

	mov RDI, 110 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr111:
	push RAX
	push RBX

	mov RDI, 111 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr112:
	push RAX
	push RBX

	mov RDI, 112 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr113:
	push RAX
	push RBX

	mov RDI, 113 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr114:
	push RAX
	push RBX

	mov RDI, 114 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr115:
	push RAX
	push RBX

	mov RDI, 115 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr116:
	push RAX
	push RBX

	mov RDI, 116 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr117:
	push RAX
	push RBX

	mov RDI, 117 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr118:
	push RAX
	push RBX

	mov RDI, 118 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr119:
	push RAX
	push RBX

	mov RDI, 119 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr120:
	push RAX
	push RBX

	mov RDI, 120 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr121:
	push RAX
	push RBX

	mov RDI, 121 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr122:
	push RAX
	push RBX

	mov RDI, 122 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr123:
	push RAX
	push RBX

	mov RDI, 123 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr124:
	push RAX
	push RBX

	mov RDI, 124 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr125:
	push RAX
	push RBX

	mov RDI, 125 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr126:
	push RAX
	push RBX

	mov RDI, 126 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr127:
	push RAX
	push RBX

	mov RDI, 127 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr128:
	push RAX
	push RBX

	mov RDI, 128 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr129:
	push RAX
	push RBX

	mov RDI, 129 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr130:
	push RAX
	push RBX

	mov RDI, 130 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr131:
	push RAX
	push RBX

	mov RDI, 131 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr132:
	push RAX
	push RBX

	mov RDI, 132 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr133:
	push RAX
	push RBX

	mov RDI, 133 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr134:
	push RAX
	push RBX

	mov RDI, 134 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr135:
	push RAX
	push RBX

	mov RDI, 135 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr136:
	push RAX
	push RBX

	mov RDI, 136 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr137:
	push RAX
	push RBX

	mov RDI, 137 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr138:
	push RAX
	push RBX

	mov RDI, 138 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr139:
	push RAX
	push RBX

	mov RDI, 139 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr140:
	push RAX
	push RBX

	mov RDI, 140 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr141:
	push RAX
	push RBX

	mov RDI, 141 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr142:
	push RAX
	push RBX

	mov RDI, 142 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr143:
	push RAX
	push RBX

	mov RDI, 143 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr144:
	push RAX
	push RBX

	mov RDI, 144 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr145:
	push RAX
	push RBX

	mov RDI, 145 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr146:
	push RAX
	push RBX

	mov RDI, 146 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr147:
	push RAX
	push RBX

	mov RDI, 147 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr148:
	push RAX
	push RBX

	mov RDI, 148 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr149:
	push RAX
	push RBX

	mov RDI, 149 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr150:
	push RAX
	push RBX

	mov RDI, 150 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr151:
	push RAX
	push RBX

	mov RDI, 151 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr152:
	push RAX
	push RBX

	mov RDI, 152 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr153:
	push RAX
	push RBX

	mov RDI, 153 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr154:
	push RAX
	push RBX

	mov RDI, 154 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr155:
	push RAX
	push RBX

	mov RDI, 155 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr156:
	push RAX
	push RBX

	mov RDI, 156 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr157:
	push RAX
	push RBX

	mov RDI, 157 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr158:
	push RAX
	push RBX

	mov RDI, 158 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr159:
	push RAX
	push RBX

	mov RDI, 159 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr160:
	push RAX
	push RBX

	mov RDI, 160 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr161:
	push RAX
	push RBX

	mov RDI, 161 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr162:
	push RAX
	push RBX

	mov RDI, 162 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr163:
	push RAX
	push RBX

	mov RDI, 163 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr164:
	push RAX
	push RBX

	mov RDI, 164 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr165:
	push RAX
	push RBX

	mov RDI, 165 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr166:
	push RAX
	push RBX

	mov RDI, 166 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr167:
	push RAX
	push RBX

	mov RDI, 167 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr168:
	push RAX
	push RBX

	mov RDI, 168 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr169:
	push RAX
	push RBX

	mov RDI, 169 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr170:
	push RAX
	push RBX

	mov RDI, 170 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr171:
	push RAX
	push RBX

	mov RDI, 171 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr172:
	push RAX
	push RBX

	mov RDI, 172 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr173:
	push RAX
	push RBX

	mov RDI, 173 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr174:
	push RAX
	push RBX

	mov RDI, 174 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr175:
	push RAX
	push RBX

	mov RDI, 175 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr176:
	push RAX
	push RBX

	mov RDI, 176 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr177:
	push RAX
	push RBX

	mov RDI, 177 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr178:
	push RAX
	push RBX

	mov RDI, 178 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr179:
	push RAX
	push RBX

	mov RDI, 179 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr180:
	push RAX
	push RBX

	mov RDI, 180 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr181:
	push RAX
	push RBX

	mov RDI, 181 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr182:
	push RAX
	push RBX

	mov RDI, 182 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr183:
	push RAX
	push RBX

	mov RDI, 183 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr184:
	push RAX
	push RBX

	mov RDI, 184 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr185:
	push RAX
	push RBX

	mov RDI, 185 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr186:
	push RAX
	push RBX

	mov RDI, 186 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr187:
	push RAX
	push RBX

	mov RDI, 187 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr188:
	push RAX
	push RBX

	mov RDI, 188 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr189:
	push RAX
	push RBX

	mov RDI, 189 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr190:
	push RAX
	push RBX

	mov RDI, 190 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr191:
	push RAX
	push RBX

	mov RDI, 191 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr192:
	push RAX
	push RBX

	mov RDI, 192 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr193:
	push RAX
	push RBX

	mov RDI, 193 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr194:
	push RAX
	push RBX

	mov RDI, 194 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr195:
	push RAX
	push RBX

	mov RDI, 195 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr196:
	push RAX
	push RBX

	mov RDI, 196 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr197:
	push RAX
	push RBX

	mov RDI, 197 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr198:
	push RAX
	push RBX

	mov RDI, 198 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr199:
	push RAX
	push RBX

	mov RDI, 199 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr200:
	push RAX
	push RBX

	mov RDI, 200 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr201:
	push RAX
	push RBX

	mov RDI, 201 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr202:
	push RAX
	push RBX

	mov RDI, 202 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr203:
	push RAX
	push RBX

	mov RDI, 203 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr204:
	push RAX
	push RBX

	mov RDI, 204 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr205:
	push RAX
	push RBX

	mov RDI, 205 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr206:
	push RAX
	push RBX

	mov RDI, 206 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr207:
	push RAX
	push RBX

	mov RDI, 207 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr208:
	push RAX
	push RBX

	mov RDI, 208 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr209:
	push RAX
	push RBX

	mov RDI, 209 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr210:
	push RAX
	push RBX

	mov RDI, 210 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr211:
	push RAX
	push RBX

	mov RDI, 211 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr212:
	push RAX
	push RBX

	mov RDI, 212 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr213:
	push RAX
	push RBX

	mov RDI, 213 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr214:
	push RAX
	push RBX

	mov RDI, 214 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr215:
	push RAX
	push RBX

	mov RDI, 215 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr216:
	push RAX
	push RBX

	mov RDI, 216 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr217:
	push RAX
	push RBX

	mov RDI, 217 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr218:
	push RAX
	push RBX

	mov RDI, 218 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr219:
	push RAX
	push RBX

	mov RDI, 219 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr220:
	push RAX
	push RBX

	mov RDI, 220 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr221:
	push RAX
	push RBX

	mov RDI, 221 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr222:
	push RAX
	push RBX

	mov RDI, 222 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr223:
	push RAX
	push RBX

	mov RDI, 223 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr224:
	push RAX
	push RBX

	mov RDI, 224 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr225:
	push RAX
	push RBX

	mov RDI, 225 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr226:
	push RAX
	push RBX

	mov RDI, 226 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr227:
	push RAX
	push RBX

	mov RDI, 227 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr228:
	push RAX
	push RBX

	mov RDI, 228 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr229:
	push RAX
	push RBX

	mov RDI, 229 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr230:
	push RAX
	push RBX

	mov RDI, 230 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr231:
	push RAX
	push RBX

	mov RDI, 231 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr232:
	push RAX
	push RBX

	mov RDI, 232 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr233:
	push RAX
	push RBX

	mov RDI, 233 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr234:
	push RAX
	push RBX

	mov RDI, 234 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr235:
	push RAX
	push RBX

	mov RDI, 235 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr236:
	push RAX
	push RBX

	mov RDI, 236 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr237:
	push RAX
	push RBX

	mov RDI, 237 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr238:
	push RAX
	push RBX

	mov RDI, 238 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr239:
	push RAX
	push RBX

	mov RDI, 239 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr240:
	push RAX
	push RBX

	mov RDI, 240 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr241:
	push RAX
	push RBX

	mov RDI, 241 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr242:
	push RAX
	push RBX

	mov RDI, 242 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr243:
	push RAX
	push RBX

	mov RDI, 243 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr244:
	push RAX
	push RBX

	mov RDI, 244 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr245:
	push RAX
	push RBX

	mov RDI, 245 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr246:
	push RAX
	push RBX

	mov RDI, 246 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr247:
	push RAX
	push RBX

	mov RDI, 247 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr248:
	push RAX
	push RBX

	mov RDI, 248 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr249:
	push RAX
	push RBX

	mov RDI, 249 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr250:
	push RAX
	push RBX

	mov RDI, 250 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr251:
	push RAX
	push RBX

	mov RDI, 251 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr252:
	push RAX
	push RBX

	mov RDI, 252 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr253:
	push RAX
	push RBX

	mov RDI, 253 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr254:
	push RAX
	push RBX

	mov RDI, 254 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr255:
	push RAX
	push RBX

	mov RDI, 255 ; isr number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq
