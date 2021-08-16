# x86-ASM-Tutorial

A collection of ASM code intended to act as a tutorial for x86 assembly.
Explanations are provided in the comments covering the concept for that section as well as the code itself.

All code in this repository requires the [NASM](https://www.nasm.us/) assembler, installable with most package managers; it can also be used in WSL.

To build the ASM files into Linux executables, use the following commands where "_file"s use the name of the ASM file you are building:

```
nasm -f elf32 asm_file.asm -o object_file.o
ld -m elf_i386 object_file.o -o executable_file
```
You can then run the executables in your terminal via `./executable_file`.

Prebuilt executables are also provided for all programs.

Enjoy! :)

