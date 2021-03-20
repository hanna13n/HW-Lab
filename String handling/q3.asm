section .data
msg1: db "Enter the first string : "
size1: equ $-msg1
msg2:db "Enter the second string : "
size2: equ $-msg2

section .bss
string1: resb 100
string2:resb 50
string_len:resb 1
temp: resb 1
n1:resb 1
n2:resb 1
temp1:resb 1

section .text
global _start:
_start:
mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, size1
int 80h

mov byte[string_len],0
mov ebx, string1
call read_array

mov al,byte[string_len]
mov byte[n1],al


mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, size2
int 80h

mov byte[string_len],0
mov ebx, string2
call read_array

mov al,byte[string_len]
mov byte[n2],al

mov edi,string1
mov esi,string2
add edi,[n1]

for:
cmp byte[esi],0
je break
mov al,byte[esi]
mov byte[edi],al
inc esi
inc edi
jmp for


break:
mov byte[edi],10
call print_array

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

cmp byte[temp], 10 ;; check if the input is   'Enter’
je end_reading
inc byte[string_len]
mov al,byte[temp]
mov byte[ebx], al
inc ebx
jmp reading
end_reading:
;; Similar to putting a null character at the end of a string
mov byte[ebx],0
popa
ret

print_array:
pusha
mov ebx, string1
printing:
mov al, byte[ebx]
mov byte[temp1], al
cmp byte[temp1], 10 ;; checks if the character is NULL character
je end_printing
push ebx
mov eax, 4
mov ebx, 1
mov ecx, temp1
mov edx, 1
int 80h
pop ebx
inc ebx
jmp printing
end_printing:
popa
ret