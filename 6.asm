[org 0x0100]  ; Define the origin address (entry point)

section .data
    Arr1 dw 1, 15, 30, 2,11, 14, 68, 120, 9, -1  ; Array of numbers (ends with -1)
    key dw 11  
    

section .text

start:
    mov dx, -1            ; Initialize DX as -1 (key not found)
    mov bx, 0             ; Initialize BX as 0 (index counter)
    mov si, Arr1          ; Move the address of Arr1 into SI
    mov cx,[key]          ; key added here

search_loop:
    cmp word [si], -1     ; Compare the current number with -1
    je end_of_array       ; If -1 is found, jump to end_of_array

    cmp word [si],cx    ; Compare the current number with the key
    je number_found       ; If they are equal, jump to number_found

    add si, 2             ; Move to the next number in the array
    add bx, 1             ; Increment the index counter
    jmp search_loop       ; Jump back to search_loop

number_found:
    mov dx, bx            ; Store the index of the found number in DX
    jmp end_of_array

end_of_array:
    mov ax, 0x4c00        ; Terminate the program
    int 0x21
