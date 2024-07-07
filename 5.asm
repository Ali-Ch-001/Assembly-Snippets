[org 0x0100]
mov bx,0
mov si, digits

check_duplicates:
mov di, si 
jmp loop1

loop2:
add si, 2
cmp word [si],-1
je end
mov di,si

loop1:
add di, 2             
cmp word [di], -1     
je end_array      
mov ax, [si]         
cmp ax, [di]          
je set_duplicate    
jmp loop1  

set_duplicate:
mov bx, 1        
jmp end  

end_array:
jmp loop2  

end:
mov ax, 0x4c00      
int 0x21


digits: dw 1,2,3,4,1,-1