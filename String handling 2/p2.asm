section .data
msg1: db "Enter the string : "
s1: equ $-msg1
msg2: db "Length of the Longest repeating sequence : "
s2: equ $-msg2
newline: db 10

section .bss
string: resb 100
temp : resb 1
string_len: resb 1
l: resb 1
large: resb 1
num: resw 1
count: resb 1

section .text
global _start:
_start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, s1
int 80h

mov byte[string_len],0
mov ebx, string
call read_array


mov ebx, string
push ebx
mov al,byte[ebx]
pop ebx

mov ebx, string
inc ebx
mov byte[l],0
mov byte[large],0
for:
push ebx
mov ah,byte[ebx]
cmp al,ah
je equal
mov bl,byte[l]
cmp byte[large],bl
jl low
reset:
mov byte[l],0
mov al,ah
jmp L  
low:
mov byte[large],bl
jmp reset
equal:
inc byte[l]
L:
pop ebx
inc ebx
dec byte[string_len]
cmp byte[string_len],0
jg for

inc byte[large]

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, s2
int 80h

mov cx,word[large]
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

cmp byte[temp], 10 ;is   'Enter’
je end_reading
inc byte[string_len]
mov al,byte[temp]
mov byte[ebx], al
inc ebx
jmp reading
end_reading:
;; Similar to puttin the end of a string
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