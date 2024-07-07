org 100h

jmp start



msg1: db 'Hi, You Pressed a', 0
msg2: db 'Hi, You Pressed b', 0
msg3: db 'Hi, You entered wrong credentials', 0
oldisr: dw 0
count: dw 0


clrscr: 
push es
push ax
push cx
push di
mov ax, 0xb800
mov es, ax ; point es to video base
xor di, di ; point di to top left column
mov ax, 0x0720 ; space char in normal attribute
mov cx, 2000 ; number of screen locations
cld ; auto increment mode
rep stosw ; clear the whole screen
pop di
pop cx
pop ax
pop es
ret

kbisr: 
push ax
push es
mov ax, 0xb800
mov es, ax           ; point es to video memory


in al, 0x60          ; read a char from keyboard port


compleft:
cmp al, 0x1e       
jne compright
mov  ah, 0x13
mov  al, 1
mov  bh, 0
mov  bl, 7
mov  dx, 0x0800
mov  cx, 17
push cs
pop  es
mov  bp, msg1
int  0x10 


compright:
cmp al, 0x30   
jne nomatch 
mov  ah, 0x13
mov  al, 1
mov  bh, 0
mov  bl, 7
mov  dx, 0x0900
mov  cx, 17
push cs
pop  es
mov  bp, msg2
int  0x10        



nomatch:
mov  ah, 0x13
mov  al, 1
mov  bh, 0
mov  bl, 7
mov  dx, 0x0A00
mov  cx, 32
push cs
pop  es
mov  bp, msg3
int  0x10 
pop es
pop ax
jmp far [cs:oldisr] 


start:

call clrscr


xor ax, ax
mov es, ax          ; point es to IVT base
mov ax, [es:9*4]
mov [oldisr], ax        ; save offset of old routine
mov ax, [es:9*4+2]
mov [oldisr+2], ax      ; save segment of old routine




cli              ; disable interrupts
mov word [es:9*4], kbisr     ; store offset at n*4
mov [es:9*4+2], cs       ; store segment at n*4+2

sti                 ; enable interrupts

mov dx,0

l1: 
mov ah, 0            ; service 0 – get keystroke
int 0x16            ; call BIOS keyboard service
inc dx
cmp dx,2
jge unhooking

cmp al, 27          ; is the Esc key pressed
jne l1               ; if no, check for next key


unhooking:
mov ax,[oldisr]
mov bx,[oldisr+2]
mov word [es:9*4], ax
mov [es:9*4+2], bx 


end:
mov ax, 0x4c00
int 0x21