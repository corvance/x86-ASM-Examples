; constants.asm
; Conaer Macpherson 16 / 08 / 2021

; This program will demonstrate creating constant variables for use in your code.

global _start


; Program data - constants
section .data
	constnum db byte 80          ; Constant number variable of 0x1234.
	
	
section .text
	; Program entrypoint.
_start:
	; Prepare for exit syscall with exit code constnum.
	; The exit syscall simply exits the program using the value in ebx as the exit code parameter.
	; The exit syscall is denoted by the code 1, which is stored in eax.
	; The int command causes a CPU interrupt.
	; The interrupt 0x80 invokes a system call (syscall) corresponding to the code in eax.
	
	mov eax, 1                   ; Move 0x01 into register eax (exit syscall).
	mov ebx, [constnum]          ; Move the value at address constnum into the ebx register as the initial exit code. [] dereferences an address, giving you the value at that location.
	int 0x80                     ; Syscall interrupt.
	
	; Running 'echo $?' once the program has executed will give you its exit code.
	; With the default value of constnum, that should be 80.
