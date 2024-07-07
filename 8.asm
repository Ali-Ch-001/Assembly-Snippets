[org 0x100]

mov bx, 0xB189          ; Initial value of BX: 1011 0001 1000 1001

; Count the number of one bits in BX
mov ax, bx              ; Copy BX to AX
mov cx, 0              ; Initialize the counter to zero

count_bits:
    shr ax, 1           ; Shift AX to the right by 1 bit
    adc cx, 0           ; Add the carry flag to the counter
    cmp ax, 0           ; Compare AX with zero
    jnz count_bits      ; Jump to count_bits if AX is not zero

mov dx, cx              ; Move the count to DX
mov ax, 0xABA5          ; Initial value of AX: 1101 1010 1011 1010

mov cx, 00000000000000001
complement_bits:
    xor ax, cx
    shl cx ,1    
    sub dx,1          
    jnz complement_bits 

mov cx, ax              ; Move the complemented value back to CX

mov ax, 0x4C00
int 0x21                ; Terminate the program