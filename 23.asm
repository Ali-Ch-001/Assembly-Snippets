[org 0x0100]

; TAKES USER INPUT ADDS IT TO BUFFER PRINTS THE MESSAGE STRING AND THEN PRINTS BUFFER MESSAGE WITH ON B800 VIDEO MODE

jmp start

message: db 'User Entered following string:$'
;following is input buffer in format required by service
buffer: db 80 ; Byte # 0: Max length of buffer
db 0 ; Byte # 1: number of characters on return
times 80 db 0 ; 80 Bytes for actual buffer space
;buffer ends
start: mov dx, buffer ; input buffer (ds:dx pointing to input buffer)

mov ah, 0x0A ; DOS' service A – buffered input
int 0x21 ; dos services call
mov bh, 0
mov bl, [buffer+1] ; read actual size in bx i.e. no of characters user

entered

mov byte [buffer+2+bx], '$' ; append $ at the end of user input
mov dx, message ; message to print
mov ah, 9 ; service 9 – write string
int 0x21 ; dos services
mov dx, buffer+2 ; user input buffer
mov ah, 9 ; service 9 – write string
int 0x21 ; dos services
mov ax, 0x4c00 ; terminate program
int 0x21