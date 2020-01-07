; Example to print hello world to the screen from the BIOS
;
; Can be used with:
;   nasm -f bin hello_world_commented.asm -o hello_world.img
;   qemu-system-x86_64 -hda hello_world.img
;


bits 16 
; All CPUs run in 16bit mode while in the BIOS

org 0x7c00 
; Sets the origin (start address)
;   0x7c00 comes from a 1981 IBM PC that used this location
;   because MS-DOS specified a minimum of 32Kb of memory (0x8000), and
;   the boot sector needs 512 bytes, the stack for the boot sector
;   is also 512 bytes. 0x8000 - (512 + 512) = 0x7c00

msg: db "Hello world"   
; This declares a label called "msg" that contains "Hello world"
;   db is Declare Byte(s) and initialize them to our message


msglen equ $-msg
; equ (equals) is a bit like #define, so #define msglen {that thing}
;   $ is the memory location of the current line
;   msg is the memory location of our message
;   so $ - msh is the number of bytes in our message

mov si, msg           
; Moves the address of our message into the SI register
;   SI is the source index register
;   used by other instructions as a pointer to the start of a string

mov ah, 0x0e          
; Moves the value 0x0e into AH
;   0x0e is the ID for the teletype function in the BIOS video services
;   AH is the High byte of register A (the first general purpose register)
;   The BIOS reads this byte we do `int 0x10`

mov bl, msglen        
; Moves the message length (declared above) into BL
;   BL is the Low byte of register B (the second general purpose register)
;   I'm using register B just because we're already using A and it's the next one


print_char:
; A label that we can jump back to later on to form a loop

    lodsb
    ; Read as: load-string-byte               
    ; an instruction that loads the current byte from the memory address in SI 
    ; and puts it into AL, then increments the address in SI

    int 0x10            
    ; Generate an interrupt that hands control over to the BIOS
    ; 0x10 is the ID for BIOS video services
    ; the BIOS video services then checks AH to see what it should do

    dec bl
    ; Decrements the value in BL
    ; this is our counter for how many characters we have left in the message

    cmp bl, 0           
    ; compare the value in BL with 0
    ; This will set some flags to indicate if the values are equal or not

    jne print_char    
    ; Read as: jump-not-equal  
    ; checks the flags set by the cmp instruction and jumps back to 
    ; the print_char label if the value in BL is not equal to 0

    hlt        
    ; Halt execution
    ; we'll end up here if the value in BL was equal to 0
    ; which would mean we have finished printing our message


times 510-($-$$) db 0
; times is {make x number of copies of thing} {thing}
; 510 because a boot sector is 512 bytes, and there's 2 bytes after this
;   $ is the memory location of the current line
;   $$ is the memory location for the start of the current section
;   So $ - $$ is the length in bytes of the current section
;   db is declare an initialized byte, db 0 is declare a byte and set it to 0

dw 0xaa55
; dw is declare an initialized word (a word is 2 bytes) 
; 0xaa55 is the BIOS magic number to say this is a bootable sector
