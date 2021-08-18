; variables.asm
; Conaer Macpherson 18/08/2021

; This program will demonstrate reserving space for uninitialised variables which can then be set at runtime.
; It will do this by storing a number in that space, printing its ASCII representation, incrementing that number, and then printing its new value's ASCII representation.

global _start


section .data
    newline db 0x0A     ; Newline constant.

section .bss
    num_char: resb 1    ; Reserve 1 byte in memory with this label.


section .text
_start:
    mov eax, 5          ; Move the number 5 into the accumulator.
    add eax, '0'        ; Add '0' to turn it into an ASCII representation.
    mov [num_char], eax ; Move that ASCII byte into the space reserved for num_char.


    ; Print the ASCII representation of num_char.
    mov eax, 4          ; sys_write syscall.
    mov ebx, 1          ; stdout file descriptor.
    mov ecx, num_char   ; Bytes to write.
    mov edx, 1          ; Number of bytes to write.
    int 0x80            ; Invoke the sys_write syscall.

    ; 
    mov eax, [num_char] ; Move the number at [num_char] into the accumulator.
    add eax, 1          ; Add 1 to it to increase its ASCII representation by 1.
    mov [num_char], eax ; Move that increased ASCII byte into the space reserve for num_char.

    ; Print the ASCII representation of [num_char]'s new value.
    mov eax, 4          ; sys_write syscall.
    mov ebx, 1          ; stdout file descriptor.
    mov ecx, num_char   ; Bytes to write.
    mov edx, 1          ; Number of bytes to write.
    int 0x80            ; Invoke the sys_write syscall.

    ; Print a newline character.
    mov eax, 4          ; sys_write syscall.
    mov ebx, 1          ; stdout file descriptor.
    mov ecx, newline    ; Bytes to write.
    mov edx, 1          ; Number of bytes to write.
    int 0x80

    ; Exit the program with exit code 0.
    mov eax, 1          ; sys_exit syscall.
    mov ebx, 0          ; Exit code 0.
    int 0x80            ; Invoke the sys_exit syscall.


; With the default values, the output should be 56.