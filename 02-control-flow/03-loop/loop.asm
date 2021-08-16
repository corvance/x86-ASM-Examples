; loop.asm
; Conaer Macpherson 16/08/2021

; This program will demonstrate how to create a loop using conditional jumps.
; The created loop will raise 3 to the power of the number stored in ecx (^ecx).
; It will do so by repeatedly multiplying 2 by itself and decrementing ecx until ecx = 0.
; The result will be stored in ebx and used as the exit code for the program for convenience.

global _start


section .text
; program entrypoint
_start:
    mov ebx, 1      ; Tnitialise ebx with 1 - it will store the result as the sys_exit exit code.
    mov ecx, 5      ; The power to raise 2 to.

loop:
    add ebx, ebx    ; ebx = ebx + ebx   ; Add ebx to itself, doubling it, since it's 2 we're raising to ecx.
    dec ecx         ; ecx = ecx - 1     ; Decrement (decrease by 1) ecx.

    cmp ecx, 0      ; Compare ecx to 0.
    jg loop         ; If ecx > 0, jump back to the start of the loop to execute code again, else carry on.

    ; Code reaches here once ecx = 0.
    mov eax, 1      ; sys_exit syscall.
    int 0x80        ; Invoke the syscall.

; Running 'echo $?' once the program has executed will give you its exit code.
; If the jump occurs successfully, that will result in 2^ecx being outputted to your terminal.
; In the default setup, that would be 32.