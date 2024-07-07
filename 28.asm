[org 0x0100]  ; Define the origin address (entry point)

section .data
    Arr1 dw 1, 15, 30, 2,11, 14, 68, 120, 9, -1  ; Array of numbers (ends with -1)
    key dw 11

msg1: db 'FOUND'
msg2: db 'NOT FOUND'


clrscr: push es
push ax
push cx
push di
mov ax, 0xb800
mov es, ax ; point es to video base
xor di, di ; point di to top left column
mov ax, 0x0720 ; space char in normal attribute
mov cx, 2000 ; number of screen locations
cld ; auto increment mode
rep stosw ; clear the whole screen
pop di
pop cx
pop ax
pop es
ret
    

section .text

start:
    mov dx, -1            ; Initialize DX as -1 (key not found)
    mov bx, 0             ; Initialize BX as 0 (index counter)
    mov si, Arr1          ; Move the address of Arr1 into SI
    mov cx,[key]          ; key added here

search_loop:
    cmp word [si], -1     ; Compare the current number with -1
    je not_found       ; If -1 is found, jump to end_of_array

    cmp word [si],cx    ; Compare the current number with the key
    je number_found       ; If they are equal, jump to number_found

    add si, 2             ; Move to the next number in the array
    add bx, 1             ; Increment the index counter
    jmp search_loop       ; Jump back to search_loop

number_found:
call clrscr
   
mov  ah, 0x13
mov  al, 1
mov  bh, 0
mov  bl, 0x8a
mov  dx, 0x0A03
mov  cx, 5
push cs
pop  es
mov  bp, msg1
int  0x10


    jmp end_of_array

 not_found:

 call clrscr

mov  ah, 0x13
mov  al, 1
mov  bh, 0
mov  bl, 0x0c
mov  dx, 0x0A03
mov  cx, 9
push cs
pop  es
mov  bp, msg2
int  0x10


end_of_array:
    mov ax, 0x4c00        ; Terminate the program
    int 0x21
