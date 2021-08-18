; if-else.asm
; Conaer Macpherson 18/08/2021

; This program will demonstrate creating if/else control flow using jump commands.
; It will print "Hello, World!" if a condition is true, and "See you later!" if it is false.

global _start

; String + length constants, and a constant value to check against for the if/else.
section .data
    hw_string db "Hello World!", 0x0A   ; 0x0A = newline character.
    hw_len equ $ - hw_string

    gw_string db "See you later!", 0x0A ; 0x0A = newline character.
    gw_len equ $ - gw_string

    cond_num db 0x04                    ; 1 byte value to compare against for the if condition.



section .text
; Program entrypoint.
_start:
    ; Prepare to call sys_write with stdout.
    mov eax, 4                          ; sys_write syscall.
    mov ebx, 1                          ; stdout file descriptor.

    cmp [cond_num], dword 0x03          ; [cond_num] == 0x03.
    jne printgw                         ; Jump to the else label if condition is false.

    ; if
    mov ecx, hw_string                  ; Load hw_string address into ecx.
    mov edx, hw_len                     ; Load hw_len (length of "Hello, World!\n") into edx.

    jmp endif                           ; Jump to the endif label following the else block, avoiding executing the else code sequentially from here.

    ; else
printgw:
    mov ecx, gw_string                  ; Load gw_string address into ecx.
    mov edx, gw_len                     ; Load gw_len (length of "Gooodbye, World!\n") into edx.
                                        
endif:
    int 0x80                            ; Invoke the sys_write syscall.

    mov eax, 1                          ; sys_exit syscall.
    mov ebx, 0                          ; Exit code 0.
    int 0x80                            ; Invoke the sys_exit syscall.


; By default, the value being compared to [cond_num] is 0x03, and [cond_num] is 0x04.
; This will result in the zero flag being cleared, and therefore the if will jump to the else label.
; In that case, "See you later!" will be outputted to your terminal.