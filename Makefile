asm_dir = src/asm
c_dir = src/c

out_dir = out

compile:
	nasm -f elf64 $(asm_dir)/multiboot_header.asm -o $(out_dir)/multiboot_header.o
	nasm -f elf64 $(asm_dir)/boot.asm -o $(out_dir)/boot.o
	nasm -f elf64 $(asm_dir)/long_mode_init.asm -o $(out_dir)/long_mode_init.o
	x86_64-elf-gcc -c -g $(c_dir)/main.c -o $(out_dir)/main.o
	ld -n -o out/kernel.bin -T linker.ld $(out_dir)/multiboot_header.o $(out_dir)/boot.o $(out_dir)/long_mode_init.o $(out_dir)/main.o

fat:
	sh create_img.sh

build: compile fat

run:
	sudo qemu-system-x86_64 -drive file=out/glennOS.img,format=raw 

clear:
	rm $(out_dir)/*