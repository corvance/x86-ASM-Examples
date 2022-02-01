# x86-ASM-Examples

A collection of ASM code examples.

All code in this repository requires the [NASM](https://www.nasm.us/) assembler, installable with most package managers; it can also be used in WSL.

To build most of the ASM files into Linux executables, use the following commands where "_file"s use the name of the ASM file you are building. Replace elf32 with win32 if you're on Windows.

```shell
nasm -f elf32 asm_file.asm -o object_file.o
ld -m elf_i386 object_file.o -o executable_file
```

Section 06 requires the gcc compiler, with build instructions in the comments.

You can then run the executables in your terminal via `./executable_file`.

Prebuilt executables are also provided for all code.

Enjoy! :)
