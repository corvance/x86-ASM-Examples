; example - factorial.asm
; Conaer Macpherson 16 / 08 / 2021

; This program will demonstrate calling C functions from x86 ASM.
; It will calculate the factorial of a number via an iterative function, demonstrating previous concepts, and print it using the C printf function.
; The factorial (!) is such that 3! = 1 * 2 * 3, 4! = 1 * 2 * 3 * 4, 5! = 1 * 2 * 3 * 4 * 5, etc.

; This program requires the gcc compiler and can be built with the following commands:
; nasm - f elf32 calling - c.asm - o calling - c.o
; gcc - m32 - no - pie - o calling - c calling - c.o


global main                  ; C uses main() as its entrypoint.
extern printf                ; Include the function.


section .text
; Program entrypoint.
main:
	push 7                       ; Push 7 to the stack as the argument to have its factorial calculated.
	call factorial
	add esp, 4                   ; Move esp back to deallocate the argument.
	
	; Push the printf arguments in reverse order.
	
	push eax                     ; Push eax containing the factorial result.
	push factorial_fstring       ; Push the fstring stored at factorial_fstring below
	call printf                  ; Call fstring with these arguments.
	add esp, 8                   ; Restore stack pointer after function call.
	
	ret                          ; Return rather than use sys_exit syscall, same as in a regular C main() function
	
	
	; Iterative factorial function.
factorial:
	; Prologue
	push ebp                     ; Preserve ebp.
	mov ebp, esp                 ; Preserve esp.
	
	mov eax, 1
	mov ecx, 1                   ; Initialise eax and ecx to 1 to start with.
	
factorial_loop:               ; Multiply eax by ecx and repeatedly increment ecx until ecx = the original number.
	
	mul ecx                      ; multiply eax by ecx
	inc ecx                      ; Increment ecx for the next loop.
	
	cmp ecx, [ebp + 8]
	jle factorial_loop           ; If ecx < the number having its factorial calculated, loop.
	
	; The function is now complete with the return value factorial stored in eax.
	
	; Epilogue
	mov esp, ebp                 ; Restore the stack pointer.
	pop ebp                      ; Restore ebp by popping it from the stack.
	
	ret                          ; Return from the function - pops the return address from the stack and jumps there.
	

	
; fstring data.
section .data:
	; Printf substitutes %i for an integer argument.
	factorial_fstring db "%i", 0x0A, 0
