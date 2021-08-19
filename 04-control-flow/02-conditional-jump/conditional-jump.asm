; conditional - jump.asm
; Conaer Macpherson 16 / 08 / 2021

; This program will demonstrate the basics of conditional jump control flow.

global _start


section .text
; Program entrypoint.
_start:
	mov ecx, 50                  ; ecx is the register which will be tested for the conditional jump.
	
	mov eax, 1                   ; sys_exit syscall.
	mov ebx, 20                  ; Exit code 20.
	
	cmp ecx, 100                 ; Compare ecx to 100 and set flags accordingly (i.e. equal, less than, greater than).
	
	; jl - jump if less than.
	; In this case, cmp evaluates ecx as being < 100, so the jump will occur.
	; If you set ecx to >= 100, the jump will not occur and exit code will be 10.
	
	jl skip                      ; Jump to label skip.
	mov ebx, 10                  ; Exit code is 10 if jump does not occur.
	
skip:
	int 0x80                     ; Invoke syscall.
	
	; Running 'echo $?' once the program has executed will give you its exit code.
	; If the jump occurs successfully, that will result in 20 being outputted to your terminal.
	
	
	
; Other conditional jumps:

; je ; jump if equal (=)
; jne ; jump if not equal (!=)
; jg ; jump if greater (>)
; jge ; jump if greater than or equal (>=)
; jl ; jump if less than (<)
; jle ; jump if less than or equal (<=)
