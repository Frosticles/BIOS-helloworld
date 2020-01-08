; Example to print hello world to the screen from the BIOS
;
; Can be used with:
;   nasm -f bin hello_world_uncommented.asm -o hello_world.img
;   qemu-system-x86_64 -hda hello_world.img
;

bits 16 
org 0x7c00 

msg: db "Hello world"
msglen equ $-msg

    mov ah, 0x13        ; write string mode for bios video services
    mov al, 1           ; write mode 1, increment cursor & attributes in BL
    mov bl, 7           ; BIOS color attributes, 7 is light gray, low nibble is forground, high is background
    mov dh, 10          ; row
    mov dl, 0           ; column
    mov bp, msg         ; base pointer to string
    mov cx, msglen      ; length of string

    int 0x10            ; call bios video services
    hlt                 ; halt

times 510-($-$$) db 0
dw 0xaa55
