[org 0x100]
jmp start

FillArray:
    push bp
    mov bp, sp
    mov di, [bp+4]  ; Load array address
    mov cx, [bp+6]  ; Load N

Fill:  
    cmp cx, 1       ; Check if N >= 1
    jl FillArrayEnd ; If N is less than 1, return

    mov bx, cx      ; Store N in BX
    mov [di], bx    ; Store N at the given address
    add di, 2       ; Move to the next element (2 bytes)
    sub cx, 1       ; Decrement N by 1

    push di         ; Save updated array address on the stack
    push cx         ; Save updated N on the stack
    call Fill       ; Recursive call
    

FillArrayEnd:
    pop bp
    ret

start:
    mov bx, array  ; Array address
    mov cx, 10    ; Number of elements to fill in the array

    push cx        ; Push N on the stack
    push bx        ; Push array address on the stack
    call FillArray ; Call the FillArray subroutine

   


    mov ax, 0x4c00
    int 0x21

array: dw 0 ; Array to be filled with numbers
