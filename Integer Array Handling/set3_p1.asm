section .data
msg1: db "Enter the number of elements : "
size1: equ $-msg1
msg2: db "Enter a number:"
size2: equ $-msg2
even: db "Even numbers : "
el: equ $-even
odd: db "Odd numbers : "
ol: equ $-odd
newline : db 10

section .bss
digit0: resb 1
digit1: resb 1
array: resb 50 
temp: resb 1
ne : resb 1
no : resb 1
num : resw 1 
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
mov edx, 2
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

mov ebx, array
mov byte[ne],0
mov byte[no],0

for:
push ebx
mov al,byte[ebx]
mov bl,2
mov ah,0
div bl
cmp ah,0
je eveninc
add byte[no],1
jmp L1
eveninc:
add byte[ne],1
L1:

pop ebx
add ebx, 1

dec byte[num]
cmp byte[num], 0
jg for


mov eax, 4
mov ebx, 1
mov ecx, even
mov edx, el
int 80h
movzx ax,byte[ne]
mov word[num],ax
call print_num
mov eax, 4
mov ebx, 1
mov ecx, odd
mov edx, ol
int 80h
movzx ax,byte[no]
mov word[num],ax
call print_num
exit:
mov eax,1
mov ebx,0
int 80h

print_num:
pusha
extract_no:
cmp word[num], 0
je print_no
inc byte[count]
mov dx, 0
mov ax, word[num]
mov bx, 10
div bx
push dx
mov word[num], ax
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
mov ecx,newline
mov edx,1
int 80h

popa
ret



