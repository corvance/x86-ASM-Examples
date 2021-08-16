; functions.asm
; Conaer Macpherson 16/08/2021

; This program will demonstrate creating functions using the call instruction.

global _start


section .text
; Program entrypoint.
_start:
    ; The call instruction pushes the current address (the EIP) to the stack, and jumps to the given address.
    ; It is essentially an all-in-one push and jump command.
    call function

    mov eax, 1      ; sys_exit syscall.
    int 0x80        ; Invoke the syscall.

; Running 'echo $?' once the program has executed will give you its exit code.
; This should result in the value which was stored in ebx in the function being outputted to your terminal.
; In the default setup, that would be 20.


function:
    mov ebx, 20     ; Exit code 20.
    ret             ; Return from the function - pops the return address from the stack and jumps there.


