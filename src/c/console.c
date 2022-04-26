#include "console.h"
#include "vga_api.h"
#include "lib.h"

char pressed_keys[] = {0x1b /*esc*/,'1','2' ,
'3' ,'4','5' ,'6',
'7' ,'8','9' ,'0',
'-' ,'=',0x8/*Backspace*/ ,0x9, /*tab*/
'Q' ,'W','E' ,'R',
'T' ,'Y','U' ,'I',
'O' ,'P','[' ,']',
'\n' /*New line*/ , 0x0/*left control*/,'A' ,'S',
'D' ,'F','G' ,'H',
'J' ,'K','L' ,';',
'\'' ,'`',0x0 /*left shift*/,'\\',
'Z' ,'X','C' ,'V',
'B' ,'N','M', ',',
'.' ,'/',0x0 /*right shift*/ ,'*',
0x0 /*left alt*/ ,' ', 0x0 /*CapsLock*/ ,0x0 /*F1*/,
0x0 /*F2*/ ,0x0 /*F3*/,0x0 /*F4*/ ,0x0 /*F5*/,
0x0 /*F6*/ ,0x0 /*F7*/,0x0 /*F8*/ ,0x0 /*F9*/,
0x0 /*F10*/ ,0x0 /*NumberLock*/,0x0 /*ScrollLock*/ ,'7',
'8' ,'9','-' ,'4',
'5' ,'6','+' ,'1',
'2' ,'3','0' ,'.'};

char is_capslock = 0;
char is_left_shift = 0;
char is_right_shift = 0;

void write_prompt() {
	VGA_display_str(CONSOLE_PROMPT);
}

// Called when key is pressed/released
void key_action(unsigned char scancode) {
	// Key pressed
	if(scancode > 0 && scancode <= 0x58) {
		unsigned char c = pressed_keys[scancode-1];
		// printkln("\nScan code: %x", scancode);
		if(c) { // if not 0x0
			if(!is_alpha(c) || is_left_shift || is_right_shift || is_capslock) {
				if(c == 0x8) { // Backspace 
					VGA_erase();
					return;
				}
				VGA_display_char(c);
				if(c == '\n') { // Line break char, print prompt again
					//TODO: Output string somehow. Need strdup() and therefore malloc
					write_prompt();
				}
			}
			
			else
				VGA_display_char(c + 32);
			return;
		}
	
		// Else, special character
		if(scancode == 0x2A) //lshift
			is_left_shift = 1;
		else if (scancode == 0x36) //rshift
			is_right_shift = 1;
		else if (scancode == 0x3A) // capslock
			is_capslock ^= 1;

	} else if(scancode == 0xAA) //lshift
		is_left_shift = 0;
	else if(scancode == 0xB6) //rshift
		is_right_shift = 0;
	// else // Probably a key-release
		// printkln("Scancode not handeled: %x", scancode);
}