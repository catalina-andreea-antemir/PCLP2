section .data
    ;delimitatori pt strtok: " .,\n" + terminator de sir '\0'
    delimiters db ' ', '.', ',', 10, 0

section .text
global sort
global get_words

extern strcmp
extern strlen
extern qsort
extern strtok

;functie auxiliara pt qsort
compare_function:
    ; create a new stack frame
    enter 0, 0
    push ebx
    push esi
    push edi

    ;primul cuvant : *(char **)a
    mov esi, [ebp + 8]
    mov esi, [esi]
    ;al doilea cuvant : *(char **)b
    mov edi, [ebp + 12]
    mov edi, [edi]

    ;facem compararea in functie de lungime
    ;aflam lungimile
    ;punem parametrii pt strlen pe stiva
    push esi
    call strlen
    ;ebx = strlen(a)
    mov ebx, eax
    pop esi

    ;punem parametrii pt strlen pe stiva
    push edi
    call strlen
    ;ecx = strlen(b)
    mov ecx, eax
    pop edi

    ;le comparam
    cmp ebx, ecx
    ;daca ebx < ecx returnam -1 < 0
    jl first_len_bigger
    ;daca ebx > ecx returnam 1 > 0
    jg second_len_bigger

    ;daca lungimile sunt egale sortam lexicografic
    ;punem parametrii pt strcmp pe stiva
    push edi
    push esi
    call strcmp
    ;scoatem parametrii de pe stiva
    add esp, 8
    jmp end_compare_function

first_len_bigger:
    ;daca primul cuvant are lungimea mai mica decat al doilea,
    ;se returneaza prin eax un numar negativ
    mov eax, -1
    jmp end_compare_function

second_len_bigger:
    ;daca primul cuvant are lungimea mai mare decat al doilea,
    ;se returneaza prin eax un numar pozitiv
    mov eax, 1
    jmp end_compare_function

end_compare_function:
    pop edi
    pop esi
    pop ebx
    leave
    ret

;; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor
;  dupa lungime si apoi lexicografix
sort:
    ; create a new stack frate
    enter 0, 0
    push ebx

    ;punem parametrii pentru qsort pe stiva
    ;functia de comparare
    push dword compare_function
    ;size : este 4 pt ca dimensiunea lui char* este de 4 octeti
    push dword [ebp + 16]
    ;number_of_words
    push dword [ebp + 12]
    ;vectorul de cuvinte words
    push dword [ebp + 8]
    call qsort
    ;scoate parametrii de pe stiva
    add esp, 16

    pop ebx
    leave
    ret

;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte
get_words:
    ; create a new stack frame
    enter 0, 0
    push ebx
    push esi
    push edi

    ;setam parametrii functiei
    ;sirul s
    mov esi, [ebp + 8]
    ;vectorul de cuvinte words
    mov edi, [ebp + 12]
    ;number_of_words
    mov ecx, [ebp + 16]

    ;initializam vectorul cu elemente nule
    mov eax, 0
empty_words_array:
    ;indexarea incepe de la number_of_words deci de acolo vine -4
    ;primul element valid este la [edi + (number_of_words - 1) * 4]
    mov [edi + ecx * 4 - 4], eax
    loop empty_words_array

    ;primul apel strtok
    ;punem parametrii pt strtok pe stiva
    push dword delimiters
    push dword esi
    call strtok
    ;scoatem parametrii de pe stiva
    add esp, 8

    ;contor pt numarul de cuvinte adaugate in word array
    mov ebx, 0
continue_strtok:
    ;avand in vedere ca am folosit ecx in loop comparam direct cu [ebp + 16]
    cmp ebx, [ebp + 16]
    jge done
    ;verificam daca fiecare token este null
    test eax, eax
    jz done

    ;adaugam tokenul (cuvantul) in vectorul de cuvinte
    mov [edi + ebx * 4], eax
    ;crestem contorul pt numarul de cuvinte din vector
    add ebx, 1

    ;punem parametrii pt strtok pe stiva
    ;urmatorul apel strtok pt urmatorul cuvant
    push dword delimiters
    ;dam push la 0 deoarece modificam delimitatorul cu null
    push dword 0
    call strtok
    ;scoatem parametrii de pe stiva
    add esp, 8
    jmp continue_strtok

done:
    pop edi
    pop esi
    pop ebx
    leave
    ret