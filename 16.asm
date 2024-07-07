ORG 100h

jmp start

MoveAsteriskAroundBorder:

MOV AX, 0B800h  ; Video memory segment
MOV ES, AX

mov di, 0
mov cx, 4000
background:
    mov word [es:di], 0x0700 ; Set background color
    add di, 2
    sub cx, 1
    jnz background

MOV DI, 0       ; Starting offset in video memory

MOV BX, 80      ; Number of columns (screen width)

TOPROW:
    MOV WORD [ES:DI], 0x072A   
    ADD DI,2         
    ;ADD AH, 2      
    CALL Delay
    SUB BX,1
    JNZ TOPROW  ; Repeat until all movements are complete

SUB DI, 2
MOV BX,25
RIGHTCOLUMN:
    MOV WORD [ES:DI], 0x072A   
    ADD DI,160         
    ADD AH, 2      
    CALL Delay
    SUB BX,1
    JNZ RIGHTCOLUMN  ; Repeat until all movements are complete

SUB DI, 160
MOV BX, 80
BOTTOMROW:
    MOV WORD [ES:DI], 0x072A   
    SUB DI,2         
    ;ADD AH, 2      
    CALL Delay
    SUB BX,1
    JNZ BOTTOMROW  ; Repeat until all movements are complete

ADD DI, 2
MOV BX,25
LEFTCOLUMN:
    MOV WORD [ES:DI], 0x072A   
    SUB DI,160         
    ADD AH, 2      
    CALL Delay
    SUB BX,1
    JNZ LEFTCOLUMN  ; Repeat until all movements are complete
End:
    RET

Delay:
    MOV DX, 30000   ; Adjust the value to control the delay length
DelayLoop:
    DEC DX
    JNZ DelayLoop
    RET


start:

CALL MoveAsteriskAroundBorder
   
 keyPress:
 mov ah, 00h     ; Wait for a keypress
 int 16h

MOV AX, 4C00h    ; Exit program
INT 21h