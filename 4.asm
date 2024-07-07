[org 0x0100]  ; Define the origin address (entry point)

mov ax, [num1]        ; Move the value of num1 into AX
mov cx, [num2]        ; Move the value of num2 into CX
xor dx, dx            ; Clear DX register (used for multiplication)

l1:
    add dx, ax        ; Add the value of num1 to the result in DX
    sub cx, 1         ; Decrement num2

    jnz l1            ; Jump to l1 if num2 is not zero

mov [product], dx     ; Move the result in DX to product

mov ax, 0x4c00        ; Terminate the program
int 0x21

num1: dw 6            ; First number (num1)
num2: dw 5            ; Second number (num2)
product: dw 0         ; Product of num1 and num2
