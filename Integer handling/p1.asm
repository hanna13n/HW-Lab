section .data
msg1 : db 'Enter First Number: '
l1: equ $-msg1
msg2 : db 'Enter Second Number: '
l2: equ $-msg2
msg3 : db 'Enter Third Number: '
l3: equ $-msg3

section .bss
d1: resb 1
d2: resb 1
n1: resb 1
junk1: resb 1
d3: resb 1
d4: resb 1
n2: resb 1
junk2 : resb 1
d5: resb 1
d6: resb 1
n3: resb 1

section .text

global _start:
    _start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, l1
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, d1
    mov edx, 1
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, d2
    mov edx, 1
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, junk1
    mov edx, 1
    int 80h

    mov al, byte[d1]
    sub al, 30h
    mov bl, 10
    mov ah, 0
    mul bl
    mov bx, word[d2]
    sub bx, 30h
    add ax, bx
    mov [n1], ax

    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, l2
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, d3
    mov edx, 1
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, d4
    mov edx, 1
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, junk2
    mov edx, 1
    int 80h

    mov al, byte[d3]
    sub al, 30h
    mov ah, 0
    mov bl, 10
    mul bl
    mov bx, word[d4]
    sub bx, 30h
    add ax, bx
    mov [n2], ax

    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, l3
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, d5
    mov edx, 1
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, d6
    mov edx, 1
    int 80h

    mov al, byte[d5]
    sub al, 30h
    mov ah, 0
    mov bl, 10
    mul bl
    mov bx, word[d6]
    sub bx, 30h
    add ax, bx
    mov [n3], ax

    mov ax, word[n1]
    cmp ax, word[n2]
    ja if1
        cmp ax, word[n3]
        ja a
        	mov ax, word[n3]
        	cmp ax, word[n2]
        	ja b
        		jmp c 

    if1:
        cmp ax, word[n3]
        ja if2
			jmp a
        if2:
            mov ax, word[n3]
            cmp ax, word[n2]
            ja c
            	jmp b

    a:
        mov eax, 4
        mov ebx, 1
        mov ecx,d1
        mov edx, 1
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, d2
        mov edx, 1
        int 80h
        jmp L

    b:
        mov eax, 4
        mov ebx, 1
        mov ecx, d3
        mov edx, 1
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, d4
        mov edx, 1
        int 80h
        jmp L

    c:
        mov eax, 4
        mov ebx, 1
        mov ecx, d5
        mov edx, 1
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, d6
        mov edx, 1
        int 80h
        jmp L

    L :
        mov eax, 1
        mov ebx, 0
        int 80h
