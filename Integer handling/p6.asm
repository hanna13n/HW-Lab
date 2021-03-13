section .data
    msg1 : db "Enter the number : "
    l1 : equ $-msg1
    prime : db " The number is prime.",10
    pl : equ $-prime
    notprime : db "The number is not prime",10
    npl : equ $-notprime
section .bss
    num : resw 1
    num1 : resw 1
    temp : resb 1
    n1 : resw 1
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
    
    mov ax,word[num1]
    mov dx,0
    mov bx,2
    div bx
    mov word[n1],ax

    mov byte[counter],2
    
    for :
        mov ax,word[num1]
        mov dx,0
        mov bx,word[counter]
        div bx
        cmp dx,0
        je np 
        add word[counter],1
        mov ax,word[counter]
        cmp ax,word[n1]
        ja pr
        jmp for
    np:
        mov eax,4
        mov ebx,1
        mov ecx,notprime
        mov edx,npl
        int 80h
        jmp exit
    pr:
        mov eax,4
        mov ebx,1
        mov ecx,prime
        mov edx,pl
        int 80h
        jmp exit
    exit:
    mov eax,1
    mov ebx,0
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


