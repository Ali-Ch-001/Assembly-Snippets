org 100h

jmp start

msg1: db 'The Sum is'

arr: db 1,2,3,4,5,6,7,8,9,10


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


printnum:
push bp
mov  bp, sp
push es
push ax
push bx
push cx
push dx
push di
mov  ax, 0xb800
mov  es, ax
mov  ax, [bp+4]
mov  bx, 10
mov cx, 0
nextdigit2:
mov  dx, 0
div  bx
add  dl, 0x30
push dx
inc  cx
cmp  ax, 0
jnz  nextdigit2
mov di, 182
nextpos2:
pop  dx
mov  dh, 0x07
mov  [es:di], dx
add  di, 2
loop nextpos2
pop  di
pop  dx
pop  cx
pop  bx
pop  ax

pop  es
pop  bp
ret  2


sum:

sum_loop:
    add al, [bx] ; Add the value at the current index to the sum
    inc bx ; Move to the next element in the array
    loop sum_loop ; Repeat the loop until CX becomes zero


push ax
call printnum

mov  ah, 0x13
mov  al, 1
mov  bh, 0
mov  bl, 7
mov  dx, 0x0100
mov  cx, 10
push cs
pop  es
mov  bp, msg1
int  0x10






   ret


start:

call clrscr

    mov ax, 0 ; Initialize the sum to zero
    mov cx, 10 ; Number of elements in the array
    mov bx, arr ; Load the address of the array into SI register

call sum


end:
mov ax, 0x4c00
int 0x21