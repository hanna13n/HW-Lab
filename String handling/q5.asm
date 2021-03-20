section .data
msg1: db "Enter a string : "
size1: equ $-msg1
msg2:db "No. of spaces in the string = "
size2:equ $-msg2
zero:db '0'
sz: equ $-zero

newline : db 10

section .bss
string: resb 50
temp: resb 1
string_len:resb 1
c:resw 1
num: resw 1
count : resb 1

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

mov word[c],0

mov ebx,string
counting:
mov al,byte[ebx]
cmp al,0
je end_counting
cmp al,' '
je inc_count
next:
inc ebx
jmp counting
end_counting:
mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, size2
int 80h

mov cx,word[c]
cmp cx,0
jne diff 
mov eax, 4
mov ebx, 1
mov ecx, zero
mov edx, sz 
int 80h
jmp exit

diff:
mov word[num],cx
call print_num

exit:
mov eax, 1
mov ebx, 0
int 80h

inc_count:
inc byte[c] 
jmp next

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