

[org 0x0100] ;we will see org directive later

xor bx, bx                 ; Clear the BX register



mov bx,2; 
add ax,bx  
mov bx,3; 
add ax,bx  
mov bx,5; 
add ax,bx  
mov bx,7; 
add ax,bx  
mov bx,11
add ax,bx  
mov bx,13; 
add ax,bx 

mov bx,17; 
add ax,bx  

mov bx,19; 
add ax,bx  
mov bx,23; 
add ax,bx  
mov bx,29; 
add ax,bx 

mov dx , ax;



mov bx, 0x4c00 ;terminate the program
int 0x21


