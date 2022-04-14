extern setup_idt
extern generic_interrupt_handler
extern print_long_hex
extern ugly_sleep

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

	push RBP

	mov RBP, [RAX]
	mov RDI, [RAX]
	call print_long_hex


	lidt [RBP]

	pop RBP

	mov RDI, 2000
	call ugly_sleep
	
	sti ; TODO: enable interrupts

	mov RDI, 5000
	
	ret

isr0:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 0 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr1:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 1 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr2:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 2 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr3:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 3 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr4:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 4 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr5:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 5 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr6:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 6 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr7:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 7 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr8:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 8 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr9:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 9 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr10:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 10 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr11:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 11 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr12:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 12 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr13:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 13 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr14:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 14 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr15:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 15 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr16:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 16 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr17:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 17 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr18:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 18 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr19:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 19 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr20:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 20 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr21:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 21 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr22:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 22 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr23:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 23 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr24:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 24 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr25:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 25 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr26:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 26 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr27:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 27 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr28:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 28 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr29:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 29 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr30:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 30 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr31:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 31 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr32:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 32 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr33:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 33 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr34:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 34 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr35:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 35 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr36:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 36 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr37:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 37 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr38:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 38 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr39:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 39 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr40:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 40 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr41:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 41 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr42:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 42 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr43:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 43 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr44:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 44 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr45:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 45 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr46:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 46 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr47:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 47 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr48:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 48 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr49:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 49 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr50:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 50 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr51:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 51 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr52:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 52 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr53:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 53 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr54:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 54 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr55:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 55 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr56:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 56 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr57:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 57 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr58:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 58 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr59:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 59 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr60:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 60 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr61:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 61 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr62:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 62 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr63:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 63 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr64:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 64 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr65:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 65 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr66:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 66 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr67:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 67 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr68:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 68 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr69:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 69 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr70:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 70 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr71:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 71 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr72:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 72 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr73:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 73 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr74:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 74 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr75:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 75 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr76:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 76 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr77:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 77 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr78:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 78 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr79:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 79 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr80:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 80 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr81:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 81 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr82:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 82 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr83:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 83 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr84:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 84 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr85:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 85 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr86:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 86 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr87:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 87 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr88:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 88 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr89:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 89 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr90:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 90 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr91:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 91 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr92:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 92 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr93:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 93 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr94:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 94 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr95:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 95 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr96:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 96 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr97:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 97 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr98:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 98 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr99:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 99 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr100:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 100 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr101:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 101 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr102:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 102 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr103:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 103 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr104:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 104 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr105:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 105 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr106:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 106 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr107:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 107 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr108:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 108 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr109:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 109 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr110:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 110 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr111:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 111 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr112:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 112 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr113:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 113 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr114:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 114 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr115:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 115 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr116:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 116 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr117:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 117 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr118:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 118 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr119:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 119 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr120:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 120 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr121:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 121 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr122:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 122 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr123:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 123 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr124:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 124 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr125:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 125 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr126:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 126 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr127:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 127 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr128:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 128 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr129:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 129 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr130:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 130 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr131:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 131 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr132:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 132 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr133:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 133 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr134:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 134 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr135:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 135 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr136:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 136 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr137:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 137 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr138:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 138 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr139:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 139 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr140:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 140 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr141:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 141 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr142:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 142 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr143:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 143 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr144:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 144 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr145:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 145 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr146:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 146 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr147:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 147 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr148:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 148 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr149:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 149 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr150:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 150 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr151:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 151 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr152:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 152 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr153:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 153 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr154:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 154 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr155:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 155 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr156:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 156 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr157:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 157 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr158:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 158 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr159:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 159 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr160:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 160 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr161:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 161 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr162:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 162 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr163:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 163 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr164:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 164 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr165:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 165 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr166:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 166 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr167:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 167 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr168:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 168 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr169:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 169 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr170:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 170 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr171:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 171 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr172:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 172 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr173:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 173 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr174:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 174 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr175:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 175 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr176:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 176 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr177:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 177 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr178:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 178 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr179:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 179 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr180:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 180 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr181:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 181 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr182:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 182 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr183:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 183 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr184:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 184 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr185:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 185 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr186:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 186 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr187:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 187 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr188:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 188 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr189:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 189 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr190:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 190 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr191:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 191 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr192:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 192 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr193:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 193 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr194:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 194 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr195:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 195 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr196:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 196 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr197:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 197 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr198:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 198 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr199:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 199 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr200:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 200 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr201:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 201 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr202:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 202 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr203:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 203 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr204:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 204 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr205:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 205 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr206:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 206 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr207:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 207 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr208:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 208 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr209:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 209 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr210:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 210 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr211:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 211 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr212:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 212 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr213:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 213 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr214:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 214 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr215:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 215 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr216:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 216 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr217:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 217 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr218:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 218 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr219:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 219 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr220:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 220 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr221:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 221 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr222:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 222 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr223:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 223 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr224:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 224 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr225:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 225 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr226:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 226 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr227:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 227 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr228:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 228 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr229:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 229 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr230:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 230 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr231:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 231 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr232:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 232 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr233:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 233 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr234:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 234 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr235:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 235 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr236:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 236 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr237:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 237 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr238:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 238 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr239:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 239 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr240:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 240 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr241:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 241 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr242:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 242 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr243:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 243 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr244:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 244 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr245:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 245 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr246:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 246 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr247:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 247 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr248:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 248 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr249:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 249 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr250:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 250 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr251:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 251 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr252:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 252 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr253:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 253 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr254:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 254 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq

isr255:
	mov RDI, 10000
	call ugly_sleep

	push RAX
	push RBX

	mov RDI, 255 ; irq number, 1st arg
	mov RSI, [RSP] ; error code, 2nd arg. Not present in some isr but doesn't matter, loading some garbage instead 

	call generic_interrupt_handler

	pop RBX
	pop RAX

	iretq
