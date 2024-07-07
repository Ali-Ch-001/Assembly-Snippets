[org 0x100]

jmp start

result: dw 0

goose:
    mov ax, -4               ; Return -4
    ret

earth:
    imul ax, 8               ; Multiply the parameter by 8
    ret

sky:
    sub ax, ax        ; Subtract the second parameter value
    ret

sheep:
    cmp ax, 0                ; Compare with 0
    jl sheep_true            ; Jump if less than 0
    xor ax, ax               ; Return 0
    ret

sheep_true:
    mov ax, 1                ; Return 1
    ret

duck:
    call sheep               ; Call the sheep function to check the condition
    test ax, ax              ; Test the returned value
    jnz duck_true            ; Jump if not zero (sheep(a) is true)
    ret

duck_true:
    neg ax                   ; Negate the parameter value
    ret

start:
    ; Call the goose function
    call goose
    mov bx, ax               ; Save the returned value in BX
    mov [result] ,bx

    ; Call the earth function
    mov ax, 5                ; Set the parameter value
    call earth
    mov cx, ax               ; Save the returned value in CX
    mov [result+2] ,cx

    ; Call the sky function
    mov ax, 10               ; Set the first parameter value
    mov bx, 3                ; Set the second parameter value
    call sky
    mov dx, ax               ; Save the returned value in DX
    mov [result+4] ,dx

    ; Call the sheep function
    mov ax, -2               ; Set the parameter value
    call sheep
    mov dx, ax               ; Save the returned value in SI
    mov [result+6] ,dx

    ; Call the duck function
    mov ax, 3                ; Set the parameter value
    call duck
    mov dx, ax               ; Save the returned value in DI
    mov [result+8] ,dx

    ; Terminate the program
    mov ax, 0x4C00
    int 0x21
