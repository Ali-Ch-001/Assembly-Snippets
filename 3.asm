[org 0x0100] 


   ; Move 200h into AX
    mov ax, 200h

    ; Move 150h into BX
    mov bx, 150h

    ; Move 25h to Memory Location 200
    mov word [200], 25h

    ; Move 15h to Memory Location 250
    mov byte [250], 15h


   ; a) Load AX with contents of memory location 200 using indirect addressing

    mov si, 200 ; Load the address of memory location 200 into SI
    mov ax, [si] ; Load the value at the memory location into AX

    ; b) Load CX with contents of memory location 250 using direct addressing

    mov cx, [250] ; Load the value at memory location 250 into CX

    ; c) Switch the contents of memory location 200 and 250 using appropriate addressing method

    mov al, byte [200] ; Load the value at memory location 200 into AL
    mov bl, byte [250] ; Load the value at memory location 250 into BL
    mov byte [200], bl ; Store the value of BL at memory location 200
    mov byte [250], al ; Store the value of AL at memory location 250

    ; d) Load the sorted array {0,0,1,1,2,3} in a new variable named temp using indexed addressing

    
    mov si, num ; Load the address of the array into SI
    mov word [temp + si], 0 ; Load 0 into temp[0]
    mov word [temp + si + 2], 0 ; Load 0 into temp[1]
    mov word [temp + si + 4], 1 ; Load 1 into temp[2]
    mov word [temp + si + 6], 1 ; Load 1 into temp[3]
    mov word [temp + si + 8], 2 ; Load 2 into temp[4]
    mov word [temp + si + 10], 3 ; Load 3 into temp[5]



mov ax, 0x4c00
int 0x21


num: dw 2,1,0,0,1,3
temp: dw 0

