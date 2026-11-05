[BITS 16]
[ORG 0x7C00]


start:
    cli
    xor ax,ax
    mov es,ax
    mov ds,ax
    mov ss,ax
    mov sp,0x7C00

    
    mov ah, 0Eh
    lea si, [msg]
    sti

    print:
        mov al, [si]
        cmp al, 0
        je stage2
        int 0x10
        inc si
        jmp print
    
stage2:
    mov ah, 0x02
    mov al, 0x01
    mov ch, 0x00
    mov cl, 0x02
    mov dh, 0x00
    mov bx, 0x7E00
    int 0x13
    cli 
    lgdt [gdt_descriptor]

    mov eax,cr0
    or eax, 1
    mov cr0, eax 
    jmp 0x08:init_pm

[BITS 32]
init_pm:
    mov ax, 0x10
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    
    mov al, "p"
    mov ah, 0x0A
    mov [0xB8000], ax
    jmp 0x7E00
end:
    hlt
    jmp end

msg db "Welcome to the club", 0
gdt_start:
    times 8 db 0
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 0x9A
    db 0xCF
    db 0x00

    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 0x92
    db 0xCF
    db 0x00
gdt_descriptor:
    dw 23
    dd gdt_start
times 510 - ($ - $$) db 0
dw 0xAA55



