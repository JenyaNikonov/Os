[BITS 32]
[ORG 0x7E00]

start:
    mov esp, 0x90000
    mov ebp, 0x90000

    in al,0x92
    or al,2
    out 0x92, al
    lea ebx, [msg]
    mov edx, 0XB8000
    mov ah, 0x0A
    print_loop:
        mov al, [ebx]
        cmp al,0
        je end
        mov [edx],al
        mov [edx+1], ah
        inc ebx
        add edx,2
        jmp print_loop


end:
    hlt
    jmp end

msg db "Welcome to the club", 0
