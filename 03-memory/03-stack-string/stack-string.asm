; stack-string.asm
; Conaer Macpherson 16/08/2021

; This program will demonstrate allocating a string on the stack then outputting it.

global _start


section .text
; Program entrypoint.
_start:
    ; Allocate space for a string on the stack.
    sub esp, 4
    ; Move the string bytes to the stack.
    ; Move is used over push so that all the characters can be stored in 4 contiguous bytes rather than 4 dwords.
    mov [esp    ], byte 'W'
    mov [esp + 1], byte 'o'
    mov [esp + 2], byte 'w'
    mov [esp + 3], byte 0x0A    ; Newline character.
    
    ; Move calls do not change esp.

    mov eax, 4      ; sys_write syscall.
    mov ebx, 1      ; stdout file descriptor.
    mov ecx, esp    ; Bytes to write.
    mov edx, 4      ; Number of bytes to write.
    int 0x80        ; Invoke the syscall.

    mov eax, 1      ; sys_exit syscall
    mov ebx, 0      ; Exit code 0.
    int 0x80        ; Invoke the syscall.

                            

