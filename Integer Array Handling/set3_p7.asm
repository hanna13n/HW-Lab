section .data
msg1 :db "Enter the no. of elements in 1st array : "
l1 : equ $-msg1
msg2 :db "Enter the numbers",10
l2 : equ $-msg2
msg3 :db "Enter the no. of elements in 2nd array : "
l3 : equ $-msg3
msg4 : db "The common elements are ",10
l4: equ $-msg4
newline : db 10
section .bss
n : resd 1
num : resw 1
temp : resb 1
temp2 : resb 1
count : resb 1
array1 : resb 50
array2 : resb 50
n1 : resb 1
n2 : resb 1
section .text
global _start:
_start:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,l1
int 80h

call read_num
mov cx,word[num]
mov word[n1],cx
mov word[n],cx

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,l2
int 80h

mov ebx,array1
mov eax,0
call read_array

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,l3
int 80h

call read_num
mov cx,word[num]
mov word[n2],cx
mov word[n],cx

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,l2
int 80h


mov eax,4
mov ebx,1
mov ecx,msg4
mov edx,l4
int 80h


mov ebx,array1
mov ecx,array2
for1:
push ebx
mov ax,word[n2]
mov word[temp2],ax
mov al,byte[ebx]
mov ecx,array2
    for2:
    push ecx
    cmp al,byte[ecx]
    je print
    jmp L1
    print:
    movzx dx,al
    mov word[num],dx
    call print_num
    jmp L1
    L1:
    pop ecx
    add ecx,1
    dec byte[temp2]
    cmp byte[temp2],0
    jg for2
    
pop ebx
add ebx,1
dec byte[n1]
cmp byte[n1],0
jg for1

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
mov word[ebx+eax],cx
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
