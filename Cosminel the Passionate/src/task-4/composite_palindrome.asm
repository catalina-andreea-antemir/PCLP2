section .data
    ;lungimea sirului inainte de concatenare
    current_len dd 0
    ;lungimea celui mai bun palindrom gasit
    best_len dd 0
    ;masca de biti
    mask dd 0
    ;pointer catre cel mai bun palindrom gasit
    best_str dd 0
    ;lungimea sirului concatenat
    len dd 0
    ;pointer catre sirul temporar construit pe parcurs
    temp_str dd 0

section .text
global check_palindrome
global composite_palindrome

extern malloc
extern free
extern strcmp
extern strlen
extern strcpy
extern strcat

check_palindrome:
    ; create a new stack frame
    enter 0, 0
    push ebx
    push edi
    push esi

    ;esi = sir
    mov esi, [ebp + 8]
    ;edi = len
    mov edi, [ebp + 12]

    ;impartitorul pt len/2
    mov ecx, 2
    ;eax = len
    mov eax, edi
    ;setam edx la 0 pt a folosi div
    mov edx, 0
    ;eax = len / 2
    div ecx
    ; ebx = len / 2
    mov ebx, eax

    ;ecx = index i
    mov ecx, 0

compare_bytes:
    cmp ecx, ebx
    je palindrom

    push ebx
    ;eax = sir[i]
    mov al, byte [esi + ecx]
    mov ebx, edi
    sub ebx, ecx
    ;edx = sir[len - i + 1]
    mov dl, byte [esi + ebx - 1]
    pop ebx

    cmp al, dl
    jne not_palindrom
    je continue_compare

continue_compare:
    ;comparam urmatoarele doua caractere
    add ecx, 1
    jmp compare_bytes

not_palindrom:
    ;returnam 0 daca cel putin doua caractere de pe pozitii simetrice difera
    mov eax, 0
    pop esi
    pop edi
    pop ebx
    leave
    ret

palindrom:
    ;returnam 1 daca pana la terminarea buclei nu s a afisat 0
    mov eax, 1
    pop esi
    pop edi
    pop ebx
    leave
    ret

composite_palindrome:
    ; create a new stack frame
    enter 0, 0
    push ebx
    push edi
    push esi

    ;vectorul de stringuri
    mov esi, [ebp + 8]
    ;numarul de elemente din vector
    mov edi, [ebp + 12]

    ;calculam 1 << len (2 ^ len)
    mov edx, 1
    mov ecx, edi

shift_loop:
    ;daca am terminat shiftarea iesim din bucla
    cmp ecx, 0
    je end_shift
    ;edx = edx * 2
    shl edx, 1
    ;decrementam contorul
    sub ecx, 1
    jmp shift_loop

end_shift:
    ;masca pentru subsiruri
    mov dword [mask], 1
    ;lungimea celui mai bun palindrom
    mov dword [best_len], 0
    ;cel mai bun palindrom
    mov dword [best_str], 0

for_loop:
    mov eax, [mask]
    ;daca am verificat toate subsirurile iesim
    cmp eax, edx
    jge end_for

    ;resetam lungimea corecta
    mov dword [current_len], 0
    ;index
    mov ecx, 0

calc_len:
    cmp ecx, edi
    je end_calc_len
    mov eax, [mask]
    ;ebx = 1 pentru calcularea lui 1 << i (2 ^ i)
    mov ebx, 1
    ;ebx = 2 ^ i (bitul pentru pozitia i)
    shl ebx, cl
    ;verificam bitul i din masca
    and eax, ebx
    ;daca bitul este 0, nu inludem sirul
    cmp eax, 0
    je skip_add_len

    ;verificam daca sirul este null
    mov eax, [esi + ecx * 4]
    ;daca este null sarim peste el
    cmp eax, 0
    je skip_add_len

    ;calculam lungimea sirului si o adaugam la current_len
    push ecx
    push edx
    ;adaugam parametrii lui strlen pe stiva
    push eax
    call strlen
    ;scoatem parametrii de pe stiva
    add esp, 4
    pop edx
    pop ecx
    ;adaugam lungimea la current_len
    add [current_len], eax

skip_add_len:
    ;trecem la urmatorul sir
    add ecx, 1
    jmp calc_len

end_calc_len:
    ;daca lungimea este 0, nu avem ce verifica deci trecem la urmatorul sir
    cmp dword [current_len], 0
    je next_iteration

    ;alocam memore pentru sirul concatenat
    mov eax, [current_len]
    ;pentru terminatorul de sir
    add eax, 1
    push ecx
    push edx
    ;punem parametrii pentru malloc pe stiva
    push eax
    call malloc
    ;scoatem parametrii de pe stiva
    add esp, 4
    pop edx
    pop ecx
    ;salvam poiterul la memoria adaugata
    mov [temp_str], eax
    ;daca alocarea nu a reusit, iesim
    cmp eax, 0
    je malloc_failed

    ;initializam sirul cu terminatorul
    mov byte [eax], 0

    ;incepem concatenarea sirurilor
    ;index pentru siruri i
    mov ecx, 0

concat_loop:
    ;daca am procesat toate sirurile iesim
    cmp ecx, edi
    je end_concat_loop

    ;verificam daca sirul i masca
    mov eax, [mask]
    ;ebx = 1 pentru a calcula 1 << i (2 ^ i)
    mov ebx, 1
    ;ebx = 2 ^ i
    shl ebx, cl
    and eax, ebx
    ;daca nu e inclus in masca il sarim
    cmp eax, 0
    je skip_concat

    ;verificam daca sirul este null
    mov eax, [esi + ecx * 4]
    ;daca este nu il concatenam
    cmp eax, 0
    je skip_concat

    ;concatem sirul la rezultat
    push ecx
    push edx
    ;punem pe stiva parametrii pentru strcat
    push eax
    push dword [temp_str]
    call strcat
    ;scoatem parametrii de pe stiva
    add esp, 8
    pop edx
    pop ecx

skip_concat:
    ;trecem la urmatorul sir
    add ecx, 1
    jmp concat_loop

end_concat_loop:
    ;calculam lungimea sirului concatenat
    push ecx
    push edx
    ;punem parametrii pt strlen pe stiva
    push dword [temp_str]
    call strlen
    ;scoatem parametrii de pe stiva
    add esp, 4
    pop edx
    pop ecx
    ;salvam lungimea
    mov [len], eax

    ;verificam daca sirul concatenat este palindrom
    push ecx
    push edx
    ;punem parametrii pentru check_palindrom pe stiva
    push dword [len]
    push dword [temp_str]
    call check_palindrome
    ;scoatem parametrii de pe stova
    add esp, 8
    pop edx
    pop ecx
    ;dca nu este palindrom trecem la urmatoarea masca
    cmp eax, 0
    je next_iteration

    ;in schimb daca este verificam daca este o varianta mai potrivita
    mov eax, [len]
    ;verificam daca lungimea este mai mare
    cmp eax, [best_len]
    ;daca este updatam sirul
    jg update_best
    ;daca nu este trecem mai departe
    jl next_iteration

    ;daca au aceeasi lungime comparam lexicografic
    ;daca sirul curent este gol il updatam
    cmp dword [best_str], 0
    je update_best
    push ecx
    push edx
    ;punem parametrii pentru strcmp pe stiva
    push dword [best_str]
    push dword [temp_str]
    call strcmp
    ;scoatem parametrii de pe stiva
    add esp, 8
    pop edx
    pop ecx
    ;daca temp_str < best_str actualizam
    cmp eax, 0
    jl update_best
    jmp next_iteration

update_best:
    ;eliveram memoria pentru vechiul palindrom
    cmp dword [best_str], 0
    je no_free_needed
    push ecx
    push edx
    ;punem parametrii pentru free pe stiva
    push dword [best_str]
    call free
    ;ii scoatem dupa apelul functiei
    add esp, 4
    pop edx
    pop ecx

no_free_needed:
    ;alocam memorie pentru noul palindrom
    mov eax, [len]
    ;pentru terminatorul de sir
    add eax, 1
    push ecx
    push edx
    ;punem pe stiva paarmetrii pentru malloc
    push eax
    call malloc
    ;scoatem parametrii de pe stiva la sfarsirul apelului
    add esp, 4
    pop edx
    pop ecx
    mov [best_str], eax
    ;daca malloc a esuat iesim
    cmp eax, 0
    je malloc_failed

    ;copiem palindromul in noua memorie de abia alocata
    push ecx
    push edx
    ;punem pe stiva parametrii pentru strcpy
    push dword [temp_str]
    push eax
    call strcpy
    ;curatam stiva
    add esp, 8
    pop edx
    pop ecx

    ;actualizam lungimea celui mai bun palindrom
    mov eax, [len]
    mov [best_len], eax

next_iteration:
    ;eliberam memoria pentru sirul temp_str
    push ecx
    push edx
    ;punem parametrii pt free pe stiva
    push dword [temp_str]
    call free
    ;curatam stiva
    add esp, 4
    pop edx
    pop ecx
    ;trecem la urmatoarea masca si continuam bucla
    add dword [mask], 1
    jmp for_loop

end_for:
    ;returnam cel mai bun palindrom
    mov eax, [best_str]
    pop esi
    pop edi
    pop ebx
    leave
    ret

malloc_failed:
    ;daca malloc esueaza returnam null
    mov eax, 0
    pop esi
    pop edi
    pop ebx
    leave
    ret