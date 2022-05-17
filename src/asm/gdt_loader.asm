global reload_segments
global ASM_load_tss
global ASM_read_cr2
global ASM_set_cr3

extern VGA_print_long_hex

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

ASM_load_tss:
     mov [RAX], DI
     ltr [RAX]

     ret

ASM_read_cr2:
     mov RAX, CR2
     ret

ASM_set_cr3:
     mov [RAX], DI
     mov cr3, RAX