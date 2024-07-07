org 100h

jmp start

msg2: db 'Original Array: '
msg3: db 'Sorted Array: '

arr: db 1, 2, 3, 4, 5, 6, 7, 8, 9, 0

clrscr: 
push es
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

print_original_array:
    ; Print the label for the original array
    mov  ah, 0x13
    mov  al, 1
    mov  bh, 0
    mov  bl, 7
    mov  dx, 0x0100
    mov  cx, 16
    push cs
    pop  es
    mov  bp, msg2
    int  0x10

    ; Print the elements of the original array
    mov  bx, arr
    mov  cx, 10
    mov di, 192
print_original_loop:
    push cx

    mov  ax, 0xb800
    mov  es, ax
    mov  ax, [bx]
    mov  bx, 10
    mov  cx, 0

nextdigit2:
        mov  dx, 0
        div  bx
        add  dl, 0x30
        push dx
        inc  cx
        cmp  ax, 0
        jnz  nextdigit2

nextpos2:
        pop  dx
        mov  dh, 0x07
        mov  [es:di], dx
        add  di, 4
        loop nextpos2

    add  bx, 1
    pop cx
    loop print_original_loop

    ret

sort_array:
    push bp
    mov bp, sp

    mov cx, 9 ; Number of elements in the array
    mov si, arr ; SI points to the start of the array

outer_loop:
    mov di, si ; DI points to the current element
    add di, 2 ; DI points to the next element

inner_loop:
        mov ax, [si] ; Load the current element into AX
        cmp ax, [di] ; Compare with the next element
        jge no_swap

        ; Swap the elements
        xchg ax, [di]
        mov [si], ax

no_swap:
        add si, 2 ; Move to the next element
        add di, 2
        loop inner_loop ; Repeat inner loop until CX becomes zero

    loop outer_loop ; Repeat outer loop until CX becomes zero

    pop bp
    ret

print_sorted_array:
; Print the label for the sorted array
    mov  ah, 0x13
    mov  al, 1
    mov  bh, 0
    mov  bl, 7
    mov  dx, 0x0100
    mov  cx, 16
    push cs
    pop  es
    mov  bp, msg3
    int  0x10


start:
    call clrscr

    call print_original_array
    call sort_array
    call print_sorted_array

    mov ax, 0x4C00
    int 0x21
