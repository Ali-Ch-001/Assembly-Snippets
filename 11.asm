[org 0x100]

jmp start 

result1: dw 0
result2: dw 0

start:
    ; First function call: MyFunction(5, 10, 15)
    mov ax, 5      ; Load first parameter a
    mov bx, 10     ; Load second parameter b
    mov cx, 15     ; Load third parameter c
    call myFunction       ; Call myFunction
    mov [result1] , dx

    

    ; Second function call: MyFunction(10, 15, 5)
    mov ax, 10    ; Load first parameter a
    mov bx, 15    ; Load second parameter b
    mov cx, 5      ; Load third parameter c
    call myFunction       ; Call myFunction
    mov [result2] , dx

    

    ; Terminate the program
    mov ax, 0x4C00
    int 0x21

myFunction:
    push bp               ; Save the base pointer
    mov bp, sp            ; Set up the new base pointer

    ; Calculate sum1 = a + b
    add ax, bx     ; Add parameter b

    ; Calculate sum2 = b + c
    add bx, cx     ; Add parameter c

    ; Compare sum1 and sum2
    cmp ax, bx            ; Compare sum1 with sum2
    jl less_than          ; Jump if sum1 < sum2

    ; Return sum2
    mov dx, bx
    jmp function_end

less_than:
    ; Return sum1
    mov dx, ax

function_end:
    mov sp, bp            ; Restore the stack pointer
    pop bp                ; Restore the base pointer
    ret
