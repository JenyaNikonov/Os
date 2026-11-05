[BITS 16]
[ORG 0x7C00]


start:
    cli
    xor ax,ax
    mov ds,ax
    mov ss,ax
    mov sp,0x7C00

    sti



