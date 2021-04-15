section .data
msg1: db "Enter the sentence : "
s1: equ $-msg1
msg2: db "The Largest word : "
s2: equ $-msg2 
msg3: db "The Smallest word : "
s3: equ $-msg3
newline: db 10

section .bss
string_len: resb 1
sentence: resb 500
temp: resb 1
largest: resb 1
smallest: resb 1
count: resb 1
w: resb 500
smallword: resb 500
largeword: resb 500
flag: resb 1

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

mov ax,word[string_len]
mov word[temp],ax

mov ebx, sentence
mov ecx, w
mov byte[count],0
mov byte[largest],0
mov byte[smallest],99
mov byte[flag],0

for:
push ebx
push ecx
mov ah, byte[ebx]
mov byte[ecx],ah
cmp byte[ebx],' '
je reset1

inc byte[count]
jmp L   

reset1:
mov byte[ecx],0
mov al,byte[count]
cmp al,byte[largest]
jg large

reset2:
cmp al,byte[smallest]
jl small

reset3:
mov byte[count],0
pop ecx
mov ecx,w 
cmp byte[flag],0
je L2
jmp ex

L:
pop ecx
inc ecx
L2:
pop ebx
inc ebx
dec byte[temp]
cmp byte[temp],0
jg for
inc byte[flag]
jmp reset1


large:
mov byte[largest],al
pusha
mov edi,largeword
mov esi,w 

move1:
mov dl,byte[esi]
mov byte[edi],dl
cmp dl,0
je break1
inc esi
inc edi
jmp move1

break1:
popa 
jmp reset2


small:
mov byte[smallest],al
pusha
mov edi,smallword
mov esi,w 

move2:
mov dl,byte[esi]
mov byte[edi],dl
cmp dl,0
je break2
inc esi
inc edi
jmp move2

break2:
popa
jmp reset3


ex:
mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, s2
int 80h

mov ebx,largeword
call print_array

mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, s3
int 80h

mov ebx,smallword
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
mov eax, 4
mov ebx, 1
mov ecx, newline
mov edx, 1
int 80h
popa
ret
