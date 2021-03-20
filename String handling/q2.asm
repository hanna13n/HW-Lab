section .data
msg1: db "Enter a string : "
size1: equ $-msg1
msg2:db "The reversed string : "
size2:equ $-msg2

section .bss
string: resb 50
temp: resb 1
string_len:resb 1

section .text
global _start:
_start:
mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, size1
int 80h

mov byte[string_len],0
mov ebx, string
call read_array

mov esi,0
mov edi,0
mov esi,string
mov edi,string
add edi,[string_len]
dec edi

reverse:
mov bl,byte[esi]
mov al,byte[edi]
mov byte[edi],bl
mov byte[esi],al
inc esi
dec edi
cmp esi,edi
jb reverse

mov ebx,string
add ebx,[string_len]
push ebx
mov byte[ebx],0
pop ebx

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, size2
int 80h

call print_array
exit:
mov eax, 1
mov ebx, 0
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
mov byte[ebx], 0

popa
ret

print_array:
pusha
mov ebx, string
printing:
mov al, byte[ebx]
mov byte[temp], al
cmp byte[temp], 0 ;; checks if the character is NULL character
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
popa
ret
