section .data
msg1: db "Enter the number of elements : "
size1: equ $-msg1
msg2: db "Enter a number:"
size2: equ $-msg2
even: db "Numbers divisible by 7 : "
el: equ $-even
odd: db " "
ol: equ $-odd



section .bss
digit0: resb 1
digit1: resb 1
array: resb 50 
element: resb 1
num : resb 1
temp: resb 1
ele : resb 1
num1 : resw 1
count : resb 1
section .text
global _start
_start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, size1
int 80h

mov eax, 3
mov ebx, 0
mov ecx, digit1
mov edx, 1
int 80h
mov eax, 3
mov ebx, 0
mov ecx, digit0
mov edx, 1
int 80h
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

sub byte[digit1], 30h
sub byte[digit0], 30h
mov al, byte[digit1]
mov dl, 10
mul dl
mov byte[num], al
mov al, byte[digit0]
add byte[num], al
mov al, byte[num]

mov byte[temp], al
mov ebx, array

reading:
push ebx 

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, size2
int 80h

mov eax, 3
mov ebx, 0
mov ecx, digit1
mov edx, 1
int 80h
mov eax, 3
mov ebx, 0
mov ecx, digit0
mov edx, 1
int 80h
mov eax, 3
mov ebx, 0
mov ecx, element
mov edx, 1
int 80h
sub byte[digit1], 30h
sub byte[digit0], 30h
mov al, byte[digit1]
mov dl, 10
mul dl
add al, byte[digit0]


pop ebx
mov byte[ebx], al
add ebx, 1

dec byte[temp]
cmp byte[temp], 0
jg reading

    mov eax,4
    mov ebx,1
    mov ecx,even
    mov edx,el
    int 80h

mov ebx, array

for:
push ebx
mov al,byte[ebx]
mov byte[ele],al
mov bl,0
mov bl,7
mov ah,0
div bl
cmp ah,0
jne L1

movzx ax,byte[ele]
mov word[num1],ax
call print_num

L1:
pop ebx
add ebx, 1

dec byte[num]
cmp byte[num], 0
jg for


exit:
mov eax,1
mov ebx,0
int 80h

print_num:
pusha
mov byte[temp],0
extract_no:
cmp word[num1], 0
je print_no
inc byte[count]
mov dx, 0
mov ax, word[num1]
mov bx, 10
div bx
push dx
mov word[num1], ax
jmp extract_no
print_no:
cmp byte[count], 0
je end_print
dec byte[count]
pop dx
mov byte[temp], dl
add byte[temp], 30h
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
jmp print_no
end_print:
mov eax,4
mov ebx,1
mov ecx,odd
mov edx,ol
int 80h

popa
ret



