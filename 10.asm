[org 0x100]

start:
    mov bx, 0xB189      ; Initial value of BX: 1011 0001 1000 1001

    ; Count the number of one bits in BX
    mov ax, bx          ; Copy BX to AX
    xor cx, cx          ; Initialize the counter to zero

count_bits:
    test ax, 1          ; Test the least significant bit of AX
    jz bit_zero         ; Jump if bit is zero

    inc cx              ; Increment CX if bit is one

bit_zero:
    shr ax, 1           ; Shift AX to the right by 1 bit
    jnz count_bits      ; Jump if AX is not zero (more bits to check)

    ; Complement the last bits of AX based on the count in CX
    mov dx, cx          ; Move the count to DX
    mov ax, 0xABA5      ; Initial value of AX: 1101 1010 1011 1010

mov cx, 00000000000000001
complement_bits:
    xor ax, cx
    shl cx ,1    
    sub dx,1          
    jnz complement_bits 
    ; Terminate the program
    mov ax, 0x4C00
    int 0x21
