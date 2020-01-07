# BIOS Hello World Example

#### A very heavily commented example to print hello world to the screen from the BIOS using NASM assembly

Can be used with:
```
nasm -f bin hello_world_commented.asm -o hello_world.img
qemu-system-x86_64 -hda hello_world.img
```

Side note: All the comments do sort of make the program look more complicated than it is, so once you've read through that there's an uncommented version that's much easier on the eyes.
