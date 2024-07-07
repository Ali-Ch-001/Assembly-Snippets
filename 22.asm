[org 0x0100]

; DEMONSTRATES HOW SEVERICE 9 WORKS TO PRINT THE WHOLE MESSAGE STRING UNTIL $ IS REACHED 

jmp start

msg1: db 'Hello World ...$' ;'$' terminated string
start: mov dx, msg1 ; ds:dx points to '$' terminated string
mov ah, 9 ; service 9 – WRITE STRING TO STANDARD OUTPUT
int 0x21 ; dos services
mov ax, 0x4c00 ; terminate program
int 0x21