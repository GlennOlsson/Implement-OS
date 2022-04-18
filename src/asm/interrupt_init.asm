extern setup_idt
extern generic_interrupt_handler
extern print_long_hex
extern ugly_sleep
extern VGA_display_char

global init_ints

global isr0
global isr1
global isr2
global isr3
global isr4
global isr5
global isr6
global isr7
global isr8
global isr9
global isr10
global isr11
global isr12
global isr13
global isr14
global isr15
global isr16
global isr17
global isr18
global isr19
global isr20
global isr21
global isr22
global isr23
global isr24
global isr25
global isr26
global isr27
global isr28
global isr29
global isr30
global isr31
global isr32
global isr33
global isr34
global isr35
global isr36
global isr37
global isr38
global isr39
global isr40
global isr41
global isr42
global isr43
global isr44
global isr45
global isr46
global isr47
global isr48
global isr49
global isr50
global isr51
global isr52
global isr53
global isr54
global isr55
global isr56
global isr57
global isr58
global isr59
global isr60
global isr61
global isr62
global isr63
global isr64
global isr65
global isr66
global isr67
global isr68
global isr69
global isr70
global isr71
global isr72
global isr73
global isr74
global isr75
global isr76
global isr77
global isr78
global isr79
global isr80
global isr81
global isr82
global isr83
global isr84
global isr85
global isr86
global isr87
global isr88
global isr89
global isr90
global isr91
global isr92
global isr93
global isr94
global isr95
global isr96
global isr97
global isr98
global isr99
global isr100
global isr101
global isr102
global isr103
global isr104
global isr105
global isr106
global isr107
global isr108
global isr109
global isr110
global isr111
global isr112
global isr113
global isr114
global isr115
global isr116
global isr117
global isr118
global isr119
global isr120
global isr121
global isr122
global isr123
global isr124
global isr125
global isr126
global isr127
global isr128
global isr129
global isr130
global isr131
global isr132
global isr133
global isr134
global isr135
global isr136
global isr137
global isr138
global isr139
global isr140
global isr141
global isr142
global isr143
global isr144
global isr145
global isr146
global isr147
global isr148
global isr149
global isr150
global isr151
global isr152
global isr153
global isr154
global isr155
global isr156
global isr157
global isr158
global isr159
global isr160
global isr161
global isr162
global isr163
global isr164
global isr165
global isr166
global isr167
global isr168
global isr169
global isr170
global isr171
global isr172
global isr173
global isr174
global isr175
global isr176
global isr177
global isr178
global isr179
global isr180
global isr181
global isr182
global isr183
global isr184
global isr185
global isr186
global isr187
global isr188
global isr189
global isr190
global isr191
global isr192
global isr193
global isr194
global isr195
global isr196
global isr197
global isr198
global isr199
global isr200
global isr201
global isr202
global isr203
global isr204
global isr205
global isr206
global isr207
global isr208
global isr209
global isr210
global isr211
global isr212
global isr213
global isr214
global isr215
global isr216
global isr217
global isr218
global isr219
global isr220
global isr221
global isr222
global isr223
global isr224
global isr225
global isr226
global isr227
global isr228
global isr229
global isr230
global isr231
global isr232
global isr233
global isr234
global isr235
global isr236
global isr237
global isr238
global isr239
global isr240
global isr241
global isr242
global isr243
global isr244
global isr245
global isr246
global isr247
global isr248
global isr249
global isr250
global isr251
global isr252
global isr253
global isr254
global isr255

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

isr0:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 0 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr1:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 1 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr2:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 2 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr3:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 3 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr4:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 4 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr5:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 5 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr6:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 6 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr7:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 7 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr8:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 8 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr9:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 9 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr10:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 10 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr11:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 11 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr12:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 12 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr13:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 13 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr14:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 14 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr15:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 15 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr16:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 16 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr17:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 17 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr18:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 18 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr19:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 19 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr20:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 20 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr21:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 21 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr22:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 22 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr23:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 23 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr24:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 24 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr25:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 25 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr26:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 26 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr27:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 27 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr28:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 28 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr29:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 29 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr30:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 30 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr31:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 31 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr32:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 32 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr33:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 33 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr34:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 34 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr35:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 35 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr36:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 36 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr37:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 37 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr38:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 38 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr39:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 39 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr40:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 40 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr41:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 41 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr42:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 42 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr43:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 43 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr44:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 44 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr45:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 45 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr46:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 46 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr47:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 47 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr48:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 48 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr49:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 49 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr50:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 50 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr51:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 51 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr52:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 52 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr53:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 53 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr54:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 54 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr55:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 55 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr56:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 56 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr57:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 57 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr58:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 58 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr59:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 59 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr60:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 60 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr61:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 61 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr62:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 62 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr63:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 63 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr64:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 64 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr65:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 65 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr66:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 66 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr67:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 67 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr68:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 68 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr69:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 69 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr70:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 70 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr71:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 71 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr72:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 72 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr73:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 73 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr74:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 74 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr75:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 75 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr76:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 76 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr77:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 77 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr78:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 78 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr79:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 79 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr80:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 80 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr81:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 81 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr82:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 82 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr83:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 83 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr84:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 84 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr85:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 85 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr86:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 86 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr87:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 87 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr88:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 88 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr89:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 89 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr90:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 90 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr91:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 91 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr92:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 92 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr93:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 93 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr94:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 94 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr95:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 95 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr96:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 96 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr97:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 97 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr98:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 98 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr99:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 99 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr100:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 100 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr101:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 101 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr102:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 102 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr103:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 103 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr104:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 104 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr105:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 105 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr106:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 106 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr107:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 107 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr108:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 108 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr109:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 109 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr110:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 110 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr111:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 111 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr112:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 112 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr113:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 113 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr114:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 114 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr115:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 115 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr116:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 116 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr117:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 117 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr118:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 118 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr119:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 119 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr120:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 120 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr121:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 121 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr122:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 122 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr123:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 123 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr124:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 124 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr125:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 125 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr126:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 126 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr127:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 127 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr128:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 128 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr129:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 129 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr130:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 130 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr131:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 131 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr132:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 132 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr133:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 133 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr134:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 134 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr135:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 135 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr136:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 136 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr137:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 137 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr138:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 138 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr139:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 139 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr140:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 140 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr141:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 141 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr142:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 142 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr143:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 143 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr144:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 144 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr145:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 145 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr146:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 146 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr147:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 147 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr148:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 148 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr149:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 149 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr150:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 150 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr151:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 151 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr152:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 152 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr153:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 153 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr154:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 154 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr155:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 155 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr156:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 156 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr157:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 157 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr158:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 158 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr159:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 159 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr160:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 160 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr161:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 161 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr162:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 162 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr163:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 163 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr164:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 164 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr165:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 165 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr166:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 166 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr167:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 167 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr168:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 168 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr169:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 169 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr170:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 170 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr171:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 171 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr172:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 172 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr173:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 173 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr174:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 174 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr175:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 175 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr176:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 176 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr177:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 177 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr178:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 178 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr179:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 179 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr180:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 180 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr181:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 181 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr182:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 182 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr183:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 183 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr184:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 184 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr185:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 185 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr186:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 186 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr187:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 187 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr188:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 188 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr189:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 189 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr190:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 190 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr191:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 191 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr192:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 192 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr193:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 193 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr194:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 194 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr195:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 195 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr196:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 196 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr197:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 197 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr198:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 198 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr199:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 199 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr200:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 200 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr201:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 201 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr202:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 202 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr203:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 203 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr204:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 204 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr205:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 205 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr206:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 206 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr207:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 207 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr208:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 208 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr209:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 209 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr210:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 210 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr211:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 211 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr212:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 212 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr213:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 213 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr214:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 214 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr215:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 215 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr216:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 216 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr217:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 217 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr218:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 218 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr219:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 219 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr220:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 220 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr221:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 221 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr222:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 222 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr223:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 223 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr224:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 224 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr225:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 225 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr226:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 226 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr227:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 227 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr228:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 228 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr229:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 229 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr230:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 230 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr231:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 231 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr232:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 232 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr233:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 233 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr234:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 234 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr235:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 235 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr236:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 236 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr237:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 237 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr238:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 238 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr239:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 239 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr240:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 240 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr241:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 241 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr242:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 242 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr243:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 243 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr244:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 244 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr245:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 245 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr246:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 246 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr247:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 247 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr248:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 248 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr249:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 249 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr250:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 250 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr251:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 251 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr252:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 252 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr253:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 253 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr254:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 254 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq

isr255:

	push RAX
	push RBX
	
	mov RDI, 10000
	call ugly_sleep

	mov RDI, 255 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	mov RDI, 4000
	call ugly_sleep

	pop RBX
	pop RAX

	iretq
