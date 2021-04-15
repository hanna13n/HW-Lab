section .data
msg1: db "Enter the sentence : "
s1: equ $-msg1
msg2: db "The required sentence : "
s2 : equ $-msg2
newline: db 10
space: db " "

section .bss
sentence : resb 500
string_len: resb 1
flag: resb 1
temp: resb 1
w: resb 500
l: resb 1


section .text
global _start:
_start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, s1
int 80h

mov byte[string_len],0
mov ebx, sentence
call read_array
mov al,byte[string_len]
mov byte[temp],al

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, s2
int 80h

mov edi, sentence
mov esi, w
add edi,[temp]
dec edi
mov byte[l],-1
mov byte[flag],0

for:
mov al,byte[edi]
mov byte[esi],al
inc byte[l]
cmp al," "
je reverse
inc esi
L2:
dec edi
dec byte[string_len]
cmp byte[string_len],0
jg for
mov byte[flag],1
inc byte[l]
reverse:
pusha
mov esi,w  
mov edi,w 
add edi,[l]
dec edi
rev:
push esi
push edi
mov bl,byte[esi]
mov ah,byte[edi]
mov byte[edi],bl
mov byte[esi],ah
pop edi
pop esi
inc esi
dec edi
cmp esi,edi
jb rev
mov esi,w 
add esi,[l]
mov byte[esi],0
popa 
mov ebx,w  
call print_array
L1:
mov byte[l],-1
mov esi,w
cmp byte[flag],0
je L2

exit:
mov eax,1
mov ebx,0
int 80h

read_array:
pusha
reading:
push ebx
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h
pop ebx

cmp byte[temp], 10 
je end_reading
inc byte[string_len]
mov al,byte[temp]
mov byte[ebx], al
inc ebx
jmp reading
end_reading:
popa
ret

print_array:
pusha
printing:
mov al, byte[ebx]
mov byte[temp], al
cmp byte[temp], 0 
je end_printing
push ebx
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
pop ebx
inc ebx
jmp printing
end_printing:
mov eax, 4
mov ebx, 1
mov ecx, space
mov edx, 1
int 80h
popa
ret
