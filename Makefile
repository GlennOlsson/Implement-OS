elf:
	nasm -f elf64 multiboot_header.asm
	nasm -f elf64 boot.asm
	ld -n -o out/kernel.bin -T linker.ld multiboot_header.o boot.o
	rm multiboot_header.o boot.o 

fat:
	sh create_img.sh

build: elf fat

run:
	sudo qemu-system-x86_64 -drive file=out/glennOS.img,format=raw 

