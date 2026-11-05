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
        je end
        int 0x10
        inc si
        jmp print
    

end:
    hlt 
    jmp end 

msg db "Welcome to the club", 0
times 510 - ($ - $$) db 0
dw 0xAA55


