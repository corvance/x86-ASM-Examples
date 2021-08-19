; functions - preserve - stack.asm
; Conaer Macpherson 16 / 08 / 2021

; This program will demonstrate passing arguments to functions using the stack.

global _start


section .text
; Program entrypoint.
_start:
	push 30                      ; Push 30 to the stack.
	call times3                  ; Call the function time3.
	add esp, 4                   ; Add 4 to the stack pointer to 'remove' the argument from the stack.
	
	mov eax, 1                   ; sys_exit syscall.
	int 0x80                     ; Invoke the syscall.
	
	; Running 'echo $?' once the program has executed will give you its exit code.
	; This should result in the value which was muliplied by 3 in ebx in the function being outputted to your terminal.
	; In the default setup, that would be 90.
	
times3:
	; Prologue
	push ebp                     ; Preserve ebp.
	mov ebp, esp                 ; Preserve esp.
	
	mov eax, [ebp + 8]           ; Store the function argument which was previously pushed to the stack in ecx.
	mov ebx, eax                 ; Initialise ebx to that argument.
	add ebx, eax
	add ebx, eax                 ; Add ecx to ebx twice, multiplying the argument by 3.
	
	; Epilogue
	mov esp, ebp                 ; Restore the stack pointer.
	pop ebp                      ; Restore ebp by popping it from the stack.
	
	ret                          ; Return from the function - pops the return address from the stack and jumps there.
