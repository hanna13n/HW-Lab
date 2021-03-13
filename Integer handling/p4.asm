section .data
    msg1 : db "Enter the 2 digit no. : "
    l1 : equ $-msg1
    msg2 : db 10
section .bss
    d1 : resb 1
    d2 : resb 1
    n1 : resw 1
    counter : resw 1
    s : resw 1
    count : resb 1
    temp : resb 1
section .text
    global _start:
    _start:

    mov eax,4
    mov ebx,1
    mov ecx,msg1
    mov edx,l1
    int 80h

    mov eax,3
    mov ebx,0
    mov ecx,d1
    mov edx,1
    int 80h

    mov eax,3
    mov ebx,0
    mov ecx,d2
    mov edx,1
    int 80h

    mov al, byte[d1]
	sub al, 30h
	mov bl, 10
	mov ah, 0
	mul bl
	mov bx, word[d2]
	sub bx, 30h
	add ax, bx
	mov word[n1], ax

    mov byte[counter],0
    mov word[s],0

    for:
        
        mov ax,word[s]
        add ax,word[counter]
        mov word[s],ax

        add byte[counter],2
        mov ax,word[counter]
        cmp ax,word[n1]
        jna for

    mov ax,[s]
    call print_num 

exit:
mov eax,1
mov ebx,0
int 80h

print_num:
    mov byte[count], 0
    push ax
push bx
push cx
push dx
push bp
push si
push di
    get_no:
        cmp word[s], 0
        je print_no
        inc byte[count]
        mov dx, 0
        mov ax, word[s]
        mov bx, 10
        div bx
        push dx
        mov word[s], ax
        jmp get_no
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
        mov eax, 4
        mov ebx, 1
        mov ecx, 10
        mov edx, 1
        int 80h
        pop di
        pop si
        pop bp
        pop dx
        pop cx
        pop bx
        pop ax
        ret




