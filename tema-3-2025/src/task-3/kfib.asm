section .text
global kfib

kfib:
    ; create a new stack frame
    enter 0, 0
    push ebx
    push edi
    push esi

    ;edi = n
    mov edi, [ebp + 8]
    ;esi = k
    mov esi, [ebp + 12]

    cmp edi, esi
    jl zero_ret
    je one_ret

    ;index i
    mov ecx, 1
    ;sum
    mov ebx, 0

sum_ret:
    cmp ecx, esi
    jg end_sum_ret

    ;copie n
    mov edx, edi
    ;edx = n-1
    sub edx, ecx

    ;salvam indexul pentru recursivitate
    push ecx
    ;adaugam parametrii pe stiva pt apelul functiei kfib
    push esi
    push edx
    call kfib
    ;scoatem parametrii de pe stiva
    add esp, 8
    ;restauram indicele
    pop ecx

    ;sum = sum + kfib(n-i)
    add ebx, eax
    ;i = i+1
    add ecx, 1
    jmp sum_ret

zero_ret:
    ;returnam 0 daca n<k
    mov eax, 0
    pop esi
    pop edi
    pop ebx
    leave
    ret

one_ret:
    ;returnam 1 daca n=k
    mov eax, 1
    pop esi
    pop edi
    pop ebx
    leave
    ret

end_sum_ret:
    ;returnam suma apelurilor recursive
    mov eax, ebx
    pop esi
    pop edi
    pop ebx
    leave
    ret

