asm_dir = src/asm
c_dir = src/c

out_dir = out

asm:
	nasm -f elf64 $(asm_dir)/multiboot_header.asm -o $(out_dir)/multiboot_header.o
	nasm -f elf64 $(asm_dir)/boot.asm -o $(out_dir)/boot.o
	nasm -f elf64 $(asm_dir)/long_mode_init.asm -o $(out_dir)/long_mode_init.o

c:
	x86_64-elf-gcc -c -g $(c_dir)/main.c -o $(out_dir)/main.o
	x86_64-elf-gcc -c -g $(c_dir)/vga_api.c -o $(out_dir)/vga_api.o
	x86_64-elf-gcc -c -g $(c_dir)/lib.c -o $(out_dir)/lib.o
	x86_64-elf-gcc -c -g $(c_dir)/ps2.c -o $(out_dir)/ps2.o

compile: asm c
	ld -n -o out/kernel.bin -T linker.ld $(out_dir)/*.o

fat:
	sh create_img.sh

build: compile fat

run:
	sudo qemu-system-x86_64 -s -drive file=out/glennOS.img,format=raw 

clear:
	rm $(out_dir)/*