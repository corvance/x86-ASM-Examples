; text-output.asm
; Conaer Macpherson 16/08/2021

; This program will demonstrate the basics of memory access by printing text to stdout.

global _start


; Program data.
section .data
    ; An example string to output.
    ; Note that it DOES NOT have a newline character in this form.
    ; This will be added at runtime.
    example_data db "This is some text, with a newline character at the end!"
    ; Determine the string's length by subtracting the address of the string, a.k.a its start, from the current address $, a.k.a its end.
    data_length equ $ - example_data

section .text
_start:
    ; Replace the last character of example_data with a newline character by moving the byte to the location of example_data's final byte.
    ; [] around a label denotes the memory that label points to, treating it like a register.

    mov [example_data + data_length - 1], byte 0x0A     ; 0x0A is the newline character.

    ; Prepare to invoke the sys_write syscall and output the data stored at label example_data.
    mov eax, 4              ; sys_write syscall
    mov ebx, 1              ; stdout file descriptor - argument denoting where to output to.
    mov ecx, example_data   ; Bytes to write.
    mov edx, data_length    ; Number of bytes to write.        
    int 0x80                ; Invoke the syscall.
    
    mov eax, 1              ; sys_exit syscall.
    mov ebx, 0              ; Exit code 0.
    int 0x80                ; Invoke the syscall.

