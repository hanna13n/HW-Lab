section .data
msg1: db "Enter the first string : "
size1: equ $-msg1
msg2:db "Enter the second string : "
size2: equ $-msg2
ne:db"The strings are different and differ at position "
nes:equ $-ne
eq:db"The strings are equal."
eqs:equ $-eq
newline: db 10


section .bss
string1: resb 50
temp: resb 1
string_len:resb 1
string2:resb 50
n1:resb 1
n2:resb 1
c:resb 1
num:resw 1
count: resb 1

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

mov ebx,string1
mov ecx,string2
mov byte[c],0
comp:
mov al,byte[ebx]
inc byte[c]
cmp al,byte[ecx]
je continue
jmp break
continue:
inc ebx
inc ecx
mov al,byte[ebx] 
cmp al,0 
je L1
jmp L2 
L1:
mov al,byte[ecx] 
cmp al,0
je equal
jmp break
L2:
mov al,byte[ecx] 
cmp al,0
je break
jmp comp

equal:
mov eax, 4
mov ebx, 1
mov ecx, eq
mov edx, eqs
int 80h
jmp exit
break:

mov eax, 4
mov ebx, 1
mov ecx, ne
mov edx, nes
int 80h

movzx cx,byte[c]
mov word[num],cx
call print_num


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

print_num:
mov byte[count],0
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