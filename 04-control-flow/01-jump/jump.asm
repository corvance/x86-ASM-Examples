; jump.asm
; Conaer Macpherson 16 / 08 / 2021

; This program will demonstrate the basics of jump control flow.

global _start


; Program code.
section .text
; Program entrypoint.
_start:
	; Prepare to exit the program with exit code 20.
	mov eax, 1                   ; sys_exit syscall.
	mov ebx, 20                  ; Exit code 20.
	
	; The jmp command jumps to the given address and continues execution there.
	; That is, it changes the instruction pointer (the EIP) to the given address.
	jmp skip                     ; Jump to label skip.
	mov ebx, 10                  ; Exit code is 10 if jump does not occur.
	
skip:
	int 0x80                     ; Invoke syscall.
	
	; Running 'echo $?' once the program has executed will give you its exit code.
	; If the jump occurs successfully, that will result in 20 being outputted to your terminal.
