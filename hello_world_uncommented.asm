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

    mov si, msg
    mov ah, 0x0e
    mov bl, msglen

print_char:
    lodsb
    int 0x10            
    dec bl
    cmp bl, 0           
    jne print_char    
    hlt        

times 510-($-$$) db 0
dw 0xaa55
