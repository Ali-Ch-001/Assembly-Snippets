[org 0x0100]
jmp start
msg1: db 'A key is pressed', 0
msg2: db 'A key is released', 0

;------------------------------------------------
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

;------------------------------------------------------
check_key_press:
    mov ah, 1 ; BIOS interrupt service 01h - Check for keypress
    int 0x16 ; Call BIOS keyboard service
    jz no_keypress ; Jump if no keypress
    mov ah, 0 ; BIOS interrupt service 00h - Get key
    int 0x16 ; Call BIOS keyboard service
    mov al, ah ; Move ASCII code to al
    mov ah, 0x0E ; BIOS interrupt service 0Eh - Teletype output
    int 0x10 ; Call BIOS video service
    no_keypress:
    ret

start: 
    call clrscr ; clear the screen

wait_for_key_press:
    call check_key_press ; Check for keypress
    jz wait_for_key_press ; If no keypress, wait

    ; Display "A key is pressed"
    mov ah, 0x13
    mov al, 1
    mov bh, 0
    mov bl, 7
    mov dx, 0x0A03
    mov cx, 17
    push cs
    pop es
    mov bp, msg1
    int 0x10

wait_for_key_release:
    call check_key_press ; Check for keypress
    jnz wait_for_key_release ; If keypress, wait

    ; Display "A key is released"
    mov ah, 0x13
    mov al, 1
    mov bh, 0
    mov bl, 7
    mov dx, 0x0B03
    mov cx, 17
    push cs
    pop es
    mov bp, msg2
    int 0x10

    mov ax, 0x4C00 ; Terminate program
    int 0x21
