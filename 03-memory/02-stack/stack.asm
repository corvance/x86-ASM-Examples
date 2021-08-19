; stack.asm
; Conaer Macpherson 16 / 08 / 2021

; This program will demonstrate the basics of the stack.

; The stack is a Last In First Out data structure.
; This means that the last item which was added to it is the first item which will be removed.
; It can be thought of like a stack of books; you both add and remove books to and from the top.

; Adding something to a stack is called pushing, and reading (removing) something from the stack is called popping.
; The pointer to the top of the stack is stored in the register esp, a.k.a the stack pointer register.
; On x86 machines, this starts at an arbitrarily high value and decreases with pushes and increases with pops.
; That can be thought of as if the stack of books starts wih one floating in midair and has books added to its bottom side.

; Stack memory addresses increase / decrease by 4 bytes as you move up and down and push / pop data.
; However, you can manually manipulate the stack pointer by whatever amounts you like.
; Be aware, however, that manually changing it by another amount after a push command may result in the wrong data being read on pop.
; For example, pushing 0x1234 decreases esp by 4, then you manually decrease it by 2.
; Popping at this point will yield 2 unknown bytes and the 2 high bytes of the pushed data.

global _start
	
	
section .text
; Program entrypoint.
_start:
	
	push 20                      ; Push the value 20 to the stack.
	
	; the above is the same as this:
	; sub esp, 4 ; Decrease the stack pointer by 4.
	; mov [esp], dword 50 ; dword = 4 bytes, there to specify we want the 32 - bit representation of 5 rather than 8 - bit.
	
	pop ebx                      ; pop the value at the stack pointer from the stack and store it in ebx, so ebx = 20
	
	; This does not actually remove the value 50 from that memory, but rather just stores it in ebx and increases esp by 4.
	; However, another push instruction would overwrite it.
	
	mov eax, 1                   ; sys_exit syscall.
	int 0x80                     ; Invoke the syscall.
	
	; Running 'echo $?' once the program has executed will give you its exit code.
	; This should result in the value which was pushed to the stack being outputted to your terminal.
	; In the default setup, that would be 20.
