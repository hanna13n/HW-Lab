section .data
msg1 : db "Enter the no. of elements : "
l1 : equ $-msg1
msg2 : db "Enter the elements " ,10
l2 : equ $-msg2
msg3 : db "The average : "
l3 : equ $-msg3
msg4 : db "The array elements :", 10
l4 :equ $-msg4
msg5 : db "The sum : "
l5: equ $-msg5
space:db " "
newline:db 10

section .bss
num: resw 1
temp: resb 1
count: resb 1
sum: resw 1
n: resd 10
array: resw 50

section .text
global _start
_start:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,l1
int 80h

call read_num
mov cx,word[num]
mov word[n],cx

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,l2
int 80h

mov ebx,array
mov eax,0
call read_array
mov ebx,array

mov eax,0
mov dx,0
loop1:
mov cx,word[ebx+2*eax]
add dx,cx
inc eax
cmp eax,dword[n]
jb loop1

mov word[sum],dx
mov word[num],dx
mov eax,4
mov ebx,1
mov ecx,msg5
mov edx,l5
int 80h
call print_num





mov ax,word[sum]
mov bx,word[n]
mov dx,0
div bx
mov word[num],ax

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,l3
int 80h

call print_num


mov eax,4
mov ebx,1
mov ecx,msg4
mov edx,l4
int 80h

mov eax,0
mov ebx,array
call print_array
exit:
mov eax,1
mov ebx,0
int 80h

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


read_array:
pusha
read_loop:
cmp eax,dword[n]
je end_read1
call read_num
;;read num stores the input in ’num’
mov cx,word[num]
mov word[ebx+2*eax],cx
inc eax
;;Here, each word consists of two bytes, so the counter should be
;;incremented by multiples of two. If the array is declared in bytes
;;do mov byte[ebx+eax],cx
jmp read_loop

end_read1:
popa
ret

print_array:
pusha
print_loop:
cmp eax,dword[n]
je end_print1
mov cx,word[ebx+2*eax]
mov word[num],cx
;;The number to be printed is copied to ’num’
;;before calling print num function
call print_num
inc eax
jmp print_loop
end_print1:
popa
ret