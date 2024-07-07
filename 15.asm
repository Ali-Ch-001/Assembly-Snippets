[org 0x100]
jmp start

Factorial:
    push bp
    mov bp, sp
    mov cx, [bp+4]    ; Load the number to calculate factorial of

    mov ax, 1         ; Initialize the factorial result to 1

FactorialLoop:
    mul cx            ; Multiply the current factorial result by the number
    loop FactorialLoop ; Decrement CX and repeat the loop until CX becomes 0

    push ax           ; Push the factorial result on the stack

    pop bp
    ret

start:
    mov cx, 5         ; Number to calculate factorial of
    push cx           ; Push the number on the stack
    call Factorial    ; Call the Factorial subroutine

    mov ax, 0x4c00
    int 0x21
