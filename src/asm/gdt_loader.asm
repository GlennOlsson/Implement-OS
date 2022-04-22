global set_gdt
global reload_segments

global print_add

extern print_long_hex
extern print_char

gdtr dw 0 ; store limit (size)
     dq 0 ; store pointer to gdt
 
set_gdt:
     mov [gdtr], DI
     mov [gdtr+2], RSI

     lgdt [gdtr]
     ret

reload_segments:
     ; Reload data segment register:
     push 0x08
     lea RAX, [rel .reload_data_seg]
     push RAX
     retfq

.reload_data_seg:
     ; load 0 into all data segment registers
     mov ax, 0x0
     mov ss, ax
     mov ds, ax
     mov es, ax
     mov fs, ax
     mov gs, ax
     
     ret

print_add:
     mov [RAX], DI
     mov [RDI], RAX
     call print_long_hex

     mov RDI, 0xA
     call print_char

     lea RDI, [rel RAX]
     call print_long_hex

     ret