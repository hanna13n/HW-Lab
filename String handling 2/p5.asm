section .data
msg1: db "Enter the  string : "
s1: equ $-msg1
msg2: db "Enter the word to be replaced : "
s2: equ $-msg2
msg3: db "Enter the new word : "
s3: equ $-msg3
msg4: db "The modified string : "
s4: equ $-msg4
space: db " "

section .bss
string: resb 100
replace: resb 100
new: resb 100
temp: resb 1
string_len: resb 1
w:resb 100
l: resb 1
f: resb 1

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

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, s2
int 80h

mov byte[string_len],0
mov ebx, replace
call read_array

mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, s3
int 80h

mov byte[string_len],0
mov ebx, new
call read_array

mov eax, 4
mov ebx, 1
mov ecx, msg4
mov edx, s4
int 80h

mov ebx,string
mov ecx,w  
mov byte[l],-1
mov byte[f],0

search:
push ebx
push ecx 
mov ah,byte[ebx]
mov byte[ecx],ah
inc byte[l]
pop ecx
inc ecx
pop ebx
inc ebx 
cmp ah,0
je flag 
cmp ah," "
jne search 
find:
pusha

mov edi,w
add edi,[l]
mov byte[edi],0


mov edx,replace
mov ecx,w  
for:
push edx
push ecx
mov bl,byte[ecx]
cmp bl,byte[edx]
jne break
pop ecx
pop edx
inc ecx
inc edx
dec byte[l]
cmp byte[l],0
jg for
popa 
jmp found 
break:
pop ecx
pop edx 
popa 
pusha
mov ebx,w 
call print_array
popa
L:
mov byte[l],-1
mov ecx,w  
cmp byte[f],0
je search 
jmp exit

flag:
inc byte[f]
jmp find 

found:
pusha
mov ebx,new
call print_array
popa
jmp L  

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
