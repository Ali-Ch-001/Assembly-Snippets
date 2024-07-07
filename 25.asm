org 100h

jmp start

oldisr: dw 0

Video: times 2000 dw 0 ; Reserve memory for storing the original video content

clrscr: 
pusha ; Save all general-purpose registers
mov ax, 0xb800
mov es, ax ; point es to video base
mov di, 0 ; point di to top left column
mov ax, 0x0720 ; space char in normal attribute
mov cx, 2000 ; number of screen locations
cld ; auto increment mode
rep stosw ; clear the whole screen
popa ; Restore all general-purpose registers
ret

display_video:
pusha ; Save all general-purpose registers
mov ax, 0xb800
mov es, ax ; point es to video base
mov di, 0 ; point di to top left column
mov si, Video ; point si to the reserved memory with original video content
mov cx, 2000 ; number of screen locations
cld ; auto increment mode
rep movsw ; copy the original video content back to video memory
popa ; Restore all general-purpose registers
ret

kbisr: 
push ax
push es
mov ax, 0xb800
mov es, ax ; point es to video memory

in al, 0x60 ; read a char from the keyboard port

; Check if the Ctrl key (0x1D) is pressed
cmp al, 0x1D
je save_video ; Ctrl key is pressed, save video memory and clear the screen
cmp al, 0x9D
jne nomatch ; Check if Ctrl key is released (0x9D)
call display_video ; Ctrl key is released, restore video memory
jmp nomatch

save_video:
; Store the original video memory content into Video
pusha
mov di, Video
mov si, 0
mov cx, 2000
cld
rep movsw
popa

call clrscr
jmp nomatch

nomatch: 
pop es
pop ax
jmp far [cs:oldisr]

start:
xor ax, ax
mov es, ax ; point es to IVT base
mov ax, [es:9*4]
mov [oldisr], ax ; save offset of old routine
mov ax, [es:9*4+2]
mov [oldisr+2], ax ; save segment of old routine

cli ; disable interrupts
mov word [es:9*4], kbisr ; store offset at n*4
mov [es:9*4+2], cs ; store segment at n*4+2
sti ; enable interrupts

l1: 
mov ah, 0x00 ; service 0 – get keystroke
int 0x16 ; call BIOS keyboard service

cmp al, 27 ; is the Esc key pressed
jne l1 ; if no, check for next key

unhooking:
mov ax, [oldisr]
mov bx, [oldisr+2]
mov word [es:9*4], ax
mov [es:9*4+2], bx 

end:
mov ax, 0x4c00
int 0x21
