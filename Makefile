elf:
	nasm -f elf64 multiboot_header.asm
	nasm -f elf64 boot.asm
	nasm -f elf64 long_mode_init.asm
	ld -n -o out/kernel.bin -T linker.ld multiboot_header.o boot.o long_mode_init.o main.o
	rm multiboot_header.o boot.o long_mode_init.o main.o

c:
	x86_64-elf-gcc -c -g main.c -o main.o

fat:
	sh create_img.sh

build: c elf fat

run:
	sudo qemu-system-x86_64 -drive file=out/glennOS.img,format=raw 

