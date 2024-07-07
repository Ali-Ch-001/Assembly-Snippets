org 100h
jmp start

CalcSizeArray:
    push bx
    cmp BX, 0 
    je EndCalcSizeArray
    mov CX, 0 
    NextElement:
        cmp word [BX], -1 
        je EndCalcSizeArray
        inc CX
        add BX, 2 
        jmp NextElement
    EndCalcSizeArray:
      pop bx  
        ret

FindMin:
    push bx
    push cx
    mov ax,0
mov dx,0
    mov AX, [BX] 
    NextElement1:
        add BX, 2 
        dec CX 
        jz EndFindMin 
        mov DX, [BX] 
        cmp DX, AX 
        jl UpdateMin 
        jmp NextElement1
    UpdateMin:
        mov AX, DX 
        jmp NextElement1
    EndFindMin: 
        pop cx
        pop bx
        ret

FindMax:
    push bx
     push cx
     mov ax,0
mov dx,0
    mov AX, [BX] 
    NextElement2:
        add BX, 2
        dec CX 
        jz EndFindMax 
        mov DX, [BX] 
        cmp DX, AX 
        jg UpdateMax
        jmp NextElement2
    UpdateMax:
        mov AX, DX ; Update the maximum element
jmp NextElement2
    EndFindMax:       
         pop cx
        pop bx
        ret

CalcSum:
    push BX
    push CX
    mov AX, [BX] 
    NextElement3:
        add BX, 2 ; Move to the next element (2 bytes)
        dec CX ; Decrement the counter
        jz EndCalcSum ; If the counter is zero, end the loop
        add AX, [BX] ; Add the current element to the sum
        jmp NextElement3
    EndCalcSum:
        pop CX
        pop BX
        ret

CalcAvg:
    push BX   
    Call CalcSum ; Calculate the sum of the elements in the array 
    mov dx, 0   
    div cx ; Divide the sum by the size of the array   
    pop BX
    ret

start:
    mov bx, arr 
    Call CalcSizeArray ; Calculate the size of the array
    push ax
    Call FindMin ; Find the minimum element in the array
    push ax
    Call FindMax ; Find the maximum element in the array
    push ax
    Call CalcSum ; Calculate the sum of the elements in the array
    push ax
    Call CalcAvg ; Calculate the average of the elements in the array
    push ax

    mov AX, 4c00h ; Exit the program
    int 21h

arr dw 19, 10, 8, 17, 9, 15, -1