; loop.asm
; Conaer Macpherson 16/08/2021

; Sometimes, you need to run a loop but all of the general-purpose registers are used within a loop.
; For exmaple, sys_write uses all 4, meaning they cannot be used as counts unless you store and recall them from memory/the stack at the start and end of each iteration.
; This can be slow, so it is useful to find another register to use.
; This is where the edi register comes in handy - amongst other things, it is useful for using as a count when general-purpose registers are busy.

global _start


section .data
    loop_str db "Loop!", 0x0A    ; 0x0A = newline character.
    len equ $ - loop_str         ; Length of str.

section .text
; program entrypoint
_start:

    xor edi, edi            ; All registers in use, so we use edi as the count for this loop. Initialise to 0 by XORIng it with itself, which is quicker than mov edi, 0.

loop:
    ; Print loop_str to stdout
    mov eax, 4              ; sys_write syscall.
    mov ebx, 1              ; stdout file descriptor.
    mov ecx, loop_str       ; Bytes to write.
    mov edx, len            ; Number of bytes to write.
    int 0x80                ; Invoke the sys_write syscall.

    inc edi                 ; Increase edi count by 1
    cmp edi, 10             ; Loop 10 times.
    jl loop                ; If edi < 10, jump back to the start of the loop to execute code again, else carry on.

    ; Code reaches here once ecx = 0.
    mov eax, 1              ; sys_exit syscall.
    int 0x80                ; Invoke the syscall.

; Running 'echo $?' once the program has executed will give you its exit code.
; If the jump occurs successfully, that will result in 2^ecx being outputted to your terminal.
; In the default setup, that would be 32.