[bits 16]
[org 0x7C00]

%DEFINE ENDL 0x0D, 0x0A

global start

start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov si, welcomemsg
    call print

print:
    lodsb
    mov ah, 0x0e
    or al, al
    jz done
    int 0x10
    jmp print

done:
    ret


welcomemsg: db "Hello from my cvs/OS Bootloader.", ENDL, 0

times 510-($-$$) db 0
dw 0xAA55