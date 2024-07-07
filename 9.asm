[org 0x0100]
jmp start

multiplicand: dd 0xABCDD4E1
multiplier: dd 0xAB5C32
result_low: dd 0
result_high: dd 0
output: dd 0

start:
mov cl, 32
mov eax, [multiplier]
mov ebx, [multiplicand] ; Load lower 32 bits of multiplicand into ebx
mov edx, [multiplicand+4] ; Load higher 32 bits of multiplicand into edx

checkbit:
shr eax, 1
jnc skip

add dword [result_low], ebx
adc dword [result_high], edx

skip:
shl ebx, 1
rcl edx, 1
dec cl
jnz checkbit

mov eax, [result_high] ; Move the value of result_high to eax
shl eax, 32 ; Shift the value of eax left by 32 bits
or eax, [result_low] ; Combine with the value of result_low

mov dword [output], eax ; Store the combined value in output

mov eax, 0x4c00
int 0x21
