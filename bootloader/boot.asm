[bits 16]
[org 0x7C00]

;Défini le saut de ligne et retour chariot CRLF
%DEFINE ENDL 0x0D, 0x0A
;Emplacement pour charger le kernel
KERNEL_OFFSET equ 0x1000

xor ax, ax        ; AX = 0
mov ds, ax        ; DS = 0  → toutes les données à partir de 0x0000
mov es, ax        ; ES = 0  → extra segment, utile pour copies
mov ss, ax        ; SS = 0  → pile dans le même segment
mov sp, 0x9000    ; SP = 0x9000 → pile en 0x0000:0x9000
mov bp, sp

;Stock le numéro du disque de démarrage
mov [BOOT_DRIVE], dl

;N'est pas obligatoire
global start

;Code ASM à inclure (modulaire)
;%include "disk.asm"
;%include "gdt.asm"
;%include "switchpm.asm"

start:
    ;Charge le message dans le registre SI
    ;Appel l'affichage du texte
    mov si, welcomemsg
    call print

    ;Charge le noyau
    mov si, loadmsg
    call print
    ;call load_kernel

    ;Bascule en mode protégé
    mov si, switchpmmsg
    call print
    ;call switch_32bits

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
welcomemsg: db "cvs/OS Bootloader v1.0", ENDL, 0
loadmsg: db "--Chargement du noyau depuis le disque", ENDL, 0
switchpmmsg: db "--Basculement vers le mode protege.", ENDL, 0

;Defini le BOOT_DRIVE sur 0
BOOT_DRIVE db 0

;Rempli l'espace pour atteindre un code de 512 bytes
times 510-($-$$) db 0
;Deux derniers octets lu par le BIOS
dw 0xAA55