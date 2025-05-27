section .text
global sort

;   struct node {
;       int val;
;       struct node* next;
;   };

;; struct node* sort(int n, struct node* node);
;   The function will link the nodes in the array
;   in ascending order and will return the address
;   of the new found head of the list
; @params:
;   n -> the number of nodes in the array
;   node -> a pointer to the beginning of the array
; @returns:
;   the address of the head of the sorted list
sort:
    ; create a new stack frame
    enter 0, 0

    ;esi = node
    mov esi, [ebp + 12]
    ;index pt parcurgerea listei
    mov ecx, 0

find_head:
    ;[ebp + 8] = n
    cmp ecx, [ebp + 8] 
    je not_found
    ; *8 vine de la structura node (4 bytes - val, 4 bytes - next)
    ;edx = valoarea nodului curent
    mov edx, [esi + ecx * 8] 
    ;1 reprezinta 'head' ul listei
    cmp edx, 1 
    je head_found
    ;daca nu l am gasit continuam cautarea
    add ecx, 1 
    jmp find_head

head_found:
    ; *8 vine de la structura node (4 bytes - val, 4 bytes - next)
    lea eax, [esi + ecx * 8] 
    ;ebx = adresa valorii elementului 'head'
    mov ebx, eax 

    ;l am gasit pe 'head' cu valoarea 1 deci cautarea incepe de la 2
    mov edi, 2 
link:
    ;[ebp + 8] = n
    cmp edi, [ebp + 8]
    ;daca am legat toate nodurile inseamna ca am terminat
    jg done 

    ;cautam nodul care era valoarea egala cu valoarea stocata in edi
    mov ecx, 0
find_next:
    ;daca am verificat toate nodurile si nu am gasit nodul cautat inseamna ca nu exista
    ;[ebp + 8] = n
    cmp ecx, [ebp + 8]
    je not_found 

    ;edx = valoarea nodului curent
    mov edx, [esi + ecx * 8] 
    cmp edx, edi
    ;daca au valorile egale inseamna ca l am gasit
    je found 
    ;daca nu l am gasit verificam urmatoarea valoare
    add ecx, 1
    jmp find_next

found:
    ;edx = adresa nodului curent
    lea edx, [esi + ecx * 8] 
    ;ebx->next = edx
    mov [ebx + 4], edx 
    ;ebx = ebx->next
    mov ebx, edx
    ;edi = 3...n
    add edi, 1
    ;trecem la urmatoarea valoare (3...n)
    jmp link 

not_found:
    ;daca nodurile cautate nu exista returnam NULL (0)
    mov eax, 0 

done:
    ;last_node->next = NULL
    mov dword [ebx + 4], 0 
    leave
    ret