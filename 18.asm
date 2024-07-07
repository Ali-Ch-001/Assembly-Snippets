org 100h


mov ax, 0xb800
mov es, ax

mov di, 0
mov cx, 4000
ClearScreen:
    mov word [es:di], 0x0700
    add di, 2
    sub cx, 1
    jnz ClearScreen



mov cx,13
mov di, 0
red:

mov bx, 40

line0:
    
    mov word [es:di], 0x4C00
    add di, 2
    sub bx, 1
    jnz line0

add di,80


loop red


mov di,2160
mov cx,12
red2:

mov bx, 40

line1:
    
    mov word [es:di], 0x4C00
    add di, 2
    sub bx, 1
    jnz line1

add di,80


loop red2



keyPress:
 mov ah, 00h     ; Wait for a keypress
 int 16h

mov AX, 4c00h ; Exit the program
int 21h
