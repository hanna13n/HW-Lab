section .data
msg1 : db "Enter the 10 numbers ",10
l1 : equ $-msg1
msg2 : db "largest : "
l2 : equ $-msg2
msg3 : db "smallest : "
l3 : equ $-msg3
msg4 : db " "
newline : db 10

section .bss
array : resb 15
num : resw 1
count : resb 1
temp : resb 1
n : resb 1
s : resb 1
l : resb 1

section .text
    global _start:
    _start:

mov word[n],10

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,l1
int 80h

mov ebx,array
mov eax,0
call read_array
mov ebx,array
mov al,0
mov dl,99

for:
push ebx
cmp al,byte[ebx]
jb large
L1:
cmp dl,byte[ebx]
ja small
jmp L2

large:
mov al,byte[ebx]
jmp L1
small:
mov dl,byte[ebx]
L2:
pop ebx
add ebx,1
dec byte[n]
cmp byte[n],0
jg for

mov byte[l],al
mov byte[s],dl

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,l2
int 80h

movzx ax,byte[l]
mov word[num],ax
call print_num

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,l3
int 80h

movzx ax,byte[s]
mov word[num],ax 
call print_num

exit:
mov eax,1
mov ebx,0
int 80h

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

read_num:

pusha


mov word[num], 0
loop_read:

mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

cmp byte[temp], 10
je end_read
mov ax, word[num]
mov bx, 10
mul bx
mov bl, byte[temp]
sub bl, 30h
mov bh, 0
add ax, bx
mov word[num], ax
jmp loop_read
end_read:

popa
ret

read_array:
pusha
read_loop:
cmp eax,dword[n]
je end_read1
call read_num
;;read num stores the input in ’num’
mov cx,word[num]
mov word[ebx+eax],cx
inc eax
;;Here, each word consists of two bytes, so the counter should be
;;incremented by multiples of two. If the array is declared in bytes
;;do mov byte[ebx+eax],cx
jmp read_loop

end_read1:
popa
ret

