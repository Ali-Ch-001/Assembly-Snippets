[org 0x0100] 


   ;a) Load 25h to Ax register and 10h to Bx
    mov ax, 25h
    mov bx, 10h

    ;b) Shift contents of Ax to Bx

    mov dx,ax
    mov ax,bx
    mov bx,dx

    ;c) Load 1234h as the contents of memory location [0x270]

    mov word [0x270], 1234h

    ;d) define array

    mov si, num ; Load the address of the array into SI
    mov al, byte [si] ; Load the first element of the array into AL
    mov al, byte [si + 1] ; Load the second element of the array AH
    mov al, byte [si + 2] ; Load the third element of the array BL



mov ax, 0x4c00
int 0x21


num : db 12, 25 ,10