section .data
msg1 : db "Enter the no. of elements : "
l1 : equ $-msg1
msg2 : db "Enter the numbers ",10
l2 : equ $-msg2
msg3 : db "Highest occurrence : "
l3 : equ $-msg3
msg4 :db "Lowest occurrence : "
l4 : equ $-msg4
space : db " "
newline : db 10
msg5 : db "hey"
l5 : equ $-msg5

section .bss
num : resw 1
temp : resb 1
count : resb 1
n : resd 1
array : resb 10
array2 : resb 10
temp2 : resb 1
l: resb 1
s:resb 1

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

    mov dx,word[n]
    mov word[temp],dx
    mov ecx,array2
    for1:
    push ecx
    mov byte[ecx],0
    pop ecx
    add ecx,1
    dec byte[temp]
    cmp byte[temp],0
    jg for1


    mov dx,word[n]
    mov word[temp],dx
    mov word[temp2],dx

    mov ebx,array
    mov edx,array
    mov ecx,array2

    for2:
    push ebx
    mov ax,word[n]
    mov word[temp2],ax
    mov al,byte[ebx]
    push ecx
    mov edx,array
    
        for3:
        push edx
        cmp al,byte[edx]
        je equal
        jmp L1
        equal:
        add byte[ecx],1
        L1:
        pop edx
        add edx,1
        dec byte[temp2]
        cmp byte[temp2],0
        jg for3
    pop ecx
    pop ebx
    add ecx,1
    add ebx,1
    dec byte[temp]
    cmp byte[temp],0
    jg for2

    mov dx,word[n]
    mov word[temp],dx

    mov ebx,array
    mov ecx,array2
    mov al,0
    mov dl,99
    for4:
    push ebx
    push ecx
    cmp al,byte[ecx]
    jb large
    L4:
    cmp dl,byte[ecx]
    ja small
    jmp L5

    large:
    mov al,byte[ecx]
    mov ah,byte[ebx]
    jmp L4
    small:
    mov dl,byte[ecx]
    mov dh,byte[ebx]
    L5:
    pop ecx
    pop ebx
    add ecx,1
    add ebx,1
    dec byte[temp]
    cmp byte[temp],0
    jg for4

    mov byte[l],ah
    mov byte[s],dh

    mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,l3
int 80h

movzx ax,byte[l]
mov word[num],ax
call print_num

mov eax,4
mov ebx,1
mov ecx,msg4
mov edx,l4
int 80h

movzx ax,byte[s]
mov word[num],ax 
call print_num

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




