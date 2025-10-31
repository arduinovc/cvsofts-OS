[bits 16]
[org 0x7C00]

;Défini le saut de ligne et retour chariot CRLF
%DEFINE ENDL 0x0D, 0x0A
;Emplacement pour charger le kernel
KERNEL_OFFSET equ 0x1000

;Stock le numéro du disque de démarrage
mov [BOOT_DRIVE], dl

;Setup le stack
mov bp, 0x9000
mov sp, bp

;N'est pas obligatoire
;global start

start:
    ;Reset le registre AX
    xor ax, ax
    ;Reset les registres DS, ES, SS
    mov ds, ax
    mov es, ax
    mov ss, ax
    ;Charge le message dans le registre SI
    mov si, welcomemsg
    ;Appel l'affichage du texte
    call print
    ;Interrompt la fonction start
    jmp $

;Boucle pour imprimer les caractères à l'écran
print:
    push ax
    push si
.loop:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp .loop
.done:
    pop si
    pop ax
    ret

;Textes à afficher
welcomemsg: db "Hello from my cvs/OS Bootloader.", ENDL, 0

;Defini le BOOT_DRIVE sur 0
BOOT_DRIVE db 0

;Rempli l'espace pour atteindre un code de 512 bytes
times 510-($-$$) db 0
;Deux derniers octets lu par le BIOS
dw 0xAA55