[org 0x100]

mov ax, 0xBAEA  
mov bx, ax      

mov cl, 4 
and ax, 0xF0F0   
shr ax, cl 
and bx, 0x0F0F   
shl bx, cl  
or ax, bx 

mov ax, 0x4C00
int 0x21
