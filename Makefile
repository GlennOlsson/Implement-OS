asm_dir = src/asm
c_dir = src/c

out_dir = out

c_flags = -c -g -Wall -Werror -mno-red-zone

create_interrupt_asm:
	python3 src/py/init_ints_generator.py

create_isr_h:
	python3 src/py/isr_header_generator.py

asm: create_interrupt_asm
	nasm -f elf64 $(asm_dir)/multiboot_header.asm -o $(out_dir)/multiboot_header.o
	nasm -f elf64 $(asm_dir)/boot.asm -o $(out_dir)/boot.o
	nasm -f elf64 $(asm_dir)/long_mode_init.asm -o $(out_dir)/long_mode_init.o
	nasm -f elf64 $(asm_dir)/interrupt_init.asm -o $(out_dir)/interrupt_init.o
	nasm -f elf64 $(asm_dir)/gdt_loader.asm -o $(out_dir)/gdt_loader.o

c: create_isr_h
	x86_64-elf-gcc $(c_flags) $(c_dir)/main.c -o $(out_dir)/main.o
	x86_64-elf-gcc $(c_flags) $(c_dir)/vga_api.c -o $(out_dir)/vga_api.o
	x86_64-elf-gcc $(c_flags) $(c_dir)/lib.c -o $(out_dir)/lib.o
	x86_64-elf-gcc $(c_flags) $(c_dir)/ps2.c -o $(out_dir)/ps2.o
	x86_64-elf-gcc $(c_flags) $(c_dir)/console.c -o $(out_dir)/console.o
	x86_64-elf-gcc $(c_flags) $(c_dir)/interrupts.c -o $(out_dir)/interrupts.o
	x86_64-elf-gcc $(c_flags) $(c_dir)/gdt.c -o $(out_dir)/gdt.o
	x86_64-elf-gcc $(c_flags) $(c_dir)/buffer.c -o $(out_dir)/buffer.o
	x86_64-elf-gcc $(c_flags) $(c_dir)/serial.c -o $(out_dir)/serial.o
	x86_64-elf-gcc $(c_flags) $(c_dir)/multiboot_parser.c -o $(out_dir)/multiboot_parser.o

compile: asm c
	ld -n -o out/kernel.bin -T linker.ld $(out_dir)/*.o

fat:
	sh create_img.sh

build: compile fat

run:
	sudo qemu-system-x86_64 -s -drive file=out/glennOS.img,format=raw -serial stdio

clear:
	rm $(out_dir)/*