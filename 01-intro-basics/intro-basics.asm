; exit-test.asm
; Conaer Macpherson 16/08/2021

; This program will introduce the basics of x86 assembly, including syntax, registers and exiting the program.

; Export the _start label as the entrypoint of the program, meaning it is where code will begin execution.
; This is a similar concept to the main function in higher-level languages.
global _start


; All code is split up into sections, for organisation and, for example, to separate code and data .
section .text:
; The _start label, where code begins execution.
; Labels are used to denote smaller sections of code [or memory] and are basically human-readable labels given to the addresses where code is stored.
_start:

    ; ASM instructions are generally 3 letters followed by comma-separated arguments.
    ; i.e. add eax, 5
    ; That instruction adds 5 to the value stored in the general purpose register eax.
    
    ; Instructions are executed sequentially. The current instruction is pointed to by the instruction pointer, or the EIP.
    ; The EIP is incremented after each instruction, so that the next can be executed.

    ; The CPU has several general-purpose registers we can use, meaning we can store any values in them whenever we want to.

    ; eax is the accumulator, generally used in arithmetic operations.
    ; ebx is the base register, generally used as a pointer to data.
    ; ecx is the count register, generally used in bitwise instructions and loops.
    ; edx is the data register, generally used in arithmetic and I/O operations.

    ; Despite these common purposes, these registers simply store 32-bit values and so can be used for anything.
    ; The registers can also be used as 16-bit registers by dropping the E from their names, i.e. ax, bx, cx
    ; You can also access those 16-bit registers in their 8-bit halves, swapping x for l for the least significant byte (LSB),
    ; and x for h for the most significant byte (MSB).

    ; The following code simply exits the program, subtracting 20 from 40 and using the result as the exit code.

    ; Prepare for exit syscall with exit code 40 - 20 = 20.
    ; The exit syscall simply exits the program using the value in ebx as the exit code parameter.
    ; The exit syscall is denoted by the code 1, which is stored in eax.
    ; The sub command subtracts the given value from the given register.
    ; The int command causes a CPU interrupt.
    ; The interrupt 0x80 invokes a system call (syscall) corresponding to the code in eax.

    mov eax, 1      ; Move 0x01 into register eax (exit syscall).
    mov ebx, 40     ; Move 40 into the ebx register as the initial exit code.
    sub ebx, 20     ; Subtract 20 from the 40 stored in ebx.
    int 0x80        ; Syscall interrupt.