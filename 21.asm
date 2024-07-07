org 0x0100
jmp start

print_ascii:
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push bp

    mov ax, 0xb800    ; Video memory segment
    mov es, ax
    mov di, 0         ; Starting offset in video memory (row 0, column 0)

print_loop:
    mov al, bl        ; Load ASCII character into AL
    mov ah, 0x07      ; Text attribute (white on black)
    stosw             ; Store ASCII character and attribute in video memory
    inc bl            ; Move to the next ASCII character
    cmp bl, 0         ; Check if we have reached the end of ASCII characters
    jnz print_loop    ; If not, continue the loop
    mov bl,0
    jmp print_loop

    pop bp
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    iret



genint0:
mov  ax, 0x8432
mov  bl, 2
div  bl
ret

start:
    xor bx, bx        ; Clear BX register (used for counting 

xor  ax, ax
mov  es, ax
mov  word [es:0*4], print_ascii ; store offset at n*4
mov  [es:0*4+2], cs
call  genint0

l1
mov ah, 0            ; service 0 – get keystroke
int 0x16            ; call BIOS keyboard service
cmp al, 27          ; is the Esc key pressed
jne l1

mov ax, 0x4c00
int 0x21