; functions - preserve - stack.asm
; Conaer Macpherson 16 / 08 / 2021

; An issue with simply using call and ret for functions is that it becomes very difficult to use the stack within functions.
; In order to be able to return to the proper address and therfore have no problems, the stack pointer must point to the return address by the time ret is called.
; It is difficult to ensure this, especially in longer functions. It may even be impossible due to how your program works.
; It is also virtually impossible to safely call functions within functions whilst modifying the stack.

; This program will demonstrate using functions in such a way that the stack can be safely used within the function, despite being needed by call and ret.
; It does this using ebp, a.k.a the Base Pointer register.
; This is essentially a register which is used to preserve the stack pointer for later use, so the stack can be freely used without losing its initial position.
; Before preserving esp in ebp, we push the initial value to the stack therefore allowing safe nested function calls.


global _start


section .text
; Program entrypoint.
_start:
	; The call instruction pushes the current address (the EIP) to the stack, and jumps to the given address.
	call function
	
	mov eax, 1                   ; sys_exit syscall.
	mov ebx, 0                   ; Exit code 0.
	int 0x80                     ; Invoke the syscall.
	
	
function:
	; Function setup a.k.a the function prologue
	push ebp                     ; Preserve ebp, allowing safe nested function calls, meaning this function can be safely called from other functions manipulating esp and ebp.
	
	mov ebp, esp                 ; Store the stack pointer in the ebp register.
	; The stack pointer at which the return address is found is now preserved, so the stack can be used freely within this function.
	
	; Allocate space for a string on the stack.
	sub esp, 4
	
	mov [esp ], byte 'H'
	mov [esp + 1], byte 'e'
	mov [esp + 2], byte 'y'
	mov [esp + 3], byte 0x0A
	
	mov eax, 4                   ; sys_write system call.
	mov ebx, 1                   ; stdout file descriptor.
	mov ecx, esp                 ; Bytes to write.
	mov edx, 4                   ; Number of bytes to write.
	int 0x80                     ; Invoke the syscall.
	
	
	; Function end a.k.a the function epilogue.
	mov esp, ebp                 ; Restore the stack pointer.
	pop ebp                      ; Restore ebp by popping it from the stack.
	
	ret                          ; Return from the function - pops the return address from the stack and jumps there.
