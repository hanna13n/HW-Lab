section .data
    msg1 : db "Enter first no. : "
    l1 : equ $-msg1
    msg2 : db "Enter Second no. : "
    l2 : equ $-msg2
    yes : db "The first no. is a multiple of the second no. "
    l3 : equ $-yes
    no : db "The first no. is not a multiple of the second no. "
    l4 : equ $-no
section .bss
    num : resw 1
    num1 : resw 1
    num2 : resw 1
    temp : resb 1
    counter : resb 1
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
    mov word[num1],cx


    mov eax,4
    mov ebx,1
    mov ecx,msg2
    mov edx,l2
    int 80h

    call read_num
    mov cx,word[num]
    mov word[num2],cx
    mov byte[counter],1
    for :
        mov ax, word[num2]
        mov dx,0
        mov bx,[counter]
        mul bx
        cmp ax,word[num1]
        jne L1
        jmp multiple
    L1:
        cmp ax,word[num1]
        ja not
        add byte[counter],1
        jmp for

        multiple:
            mov eax, 4
            mov ebx, 1
            mov ecx, yes
            mov edx, l3
            int 80h
            jmp exit
        not :
            mov eax, 4
            mov ebx, 1
            mov ecx, no
            mov edx, l4
            int 80h
            jmp exit

   
    exit :
     mov eax, 1
	 mov ebx, 0
	 int 80h


read_num:

push ax
push bx
push cx
push dx
push bp
push si
push di


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

pop di
pop si
pop bp
pop dx
pop cx
pop bx
pop ax
ret



    




