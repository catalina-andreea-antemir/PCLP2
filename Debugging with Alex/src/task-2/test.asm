%include "../include/io.mac"


; E FARA STRCMP SI DA SEG FAULT ACUM, DAR POATE IL COMPLETEAZA CHAT ;BINE


; 1 + 1 + 2 bytes
%define DATE_SIZE 4


; 31 + 1 + 4 bytes
%define EVENT_SIZE (31 + 1 + DATE_SIZE)


; 31 + 1 bytes
%define EVENT_DATE 32


; 31 bytes
%define EVENT_VALID 31


; declare your structs here
struc date
   day:       resb 1  ; 1 byte
   month:     resb 1  ; 1 byte
   year:      resw 1  ; 2 bytes
enstruc


struc event
   name:       resb 31  ; 31 bytes
   valid:      resb 1   ; 1 byte
   date_filed: resb DATE_SIZE  ; 4 bytes
endstruc


section .text
global sort_events
extern printf


sort_events:
   ;; DO NOT MODIFY
   enter 0, 0
   pusha


   mov ebx, [ebp + 8]  ; events
   mov ecx, [ebp + 12]  ; length


   ;; DO NOT MODIFY
   ;; Your code starts here


   mov esi, ecx  ; salvez lungimea originala
   sub esp, EVENT_SIZE  ; aloc 4 bytes pe stiva pt interschimbare


bubble_loop:
   xor edx, edx  ; il folosesc ca falg pt a marca o interschimbare


   ; loop_count va fi lungimea - 1
   mov ecx, esi
   dec ecx  ; ca sa compar perechi vecine


   mov edi, ebx  ; edi este pointer la event[i]


bubble_sort:
   ; calculez pointer ul pt al doilea eveniment
   mov ebp, edi  ; copiez adresa lui event[i]
   add ebp, EVENT_SIZE  ; ebp = event[i+1]


   ; acum compar event[i] cu event[i+1]


   ; compar campul valid
   mov al, byte [edi + EVENT_VALID]  ; al = event[i].valid
   mov bl, byte [ebp + EVENT_VALID]  ; bl = event[i+1].valid


   cmp al, bl
   jne cmp_valid
   jmp cmp_date  ; daca campul valid este egal, se compara data


cmp_valid:
   ; daca event[i].valid < event[i+1].valid, trebuie interschimbat
   jb swap
   jmp no_swap


cmp_date:
   ; se compara anul
   mov ax, word [edi + EVENT_DATE + 2]  ; ax = event[i].year
   mov cx, word [ebp + EVENT_DATE + 2]  ; cx = event[i+1].year


   cmp ax, cx
   jne cmp_year


   ; daca anii sunt egali, se compara luna
   mov al, byte [edi + EVENT_DATE + 1]  ; al = event[i].month
   mov bl, byte [ebp + EVENT_DATE + 1]  ; bl = event[i+1].month


   cmp al, bl
   jne cmp_month


   ; daca lunile sunt egale, se compara zilele
   mov al, byte [edi + EVENT_DATE]  ; al = event[i].day
   mov bl, byte [ebp + EVENT_DATE]  ; bl = event[i+1].day


   cmp al, bl
   jne cmp_day


   ; daca datele sunt identice, se compara numele
   push dword [edi]
   push dword [ebp]


cmp_year:
   cmp ax, cx
   ja swap
   jmp no_swap


cmp_month:
   cmp al, bl
   ja swap
   jmp no_swap


cmp_day:
   cmp al, bl
   ja swap
   jmp no_swap


swap:
   mov edx, 1  ; flag ul de interschimbare
   mov eax, edi  ; salvez pointer la event[i]


   push ecx  ; salvez contorul


   ; copiez event[i] in buffer temporal, adica la esp
   mov ecx, EVENT_SIZE
   mov esi, eax  ; sursa = event[i]
   mov edi, esp  ; dest = buffer temporal
   rep movsb


   ; copiez event[i+1] de la ebp in event[i], la adresa din eax
   mov ecx, EVENT_SIZE
   mov esi, ebp
   mov edi, eax
   rep movsb


   ; copiez buffer temporar in event[i+1], la ebp
   mov ecx, EVENT_SIZE
   mov esi, esp
   mov edi, ebp
   rep movsb


   pop ecx  ; intorc contorul


no_swap:
   ; trec la urm event
   add edi, EVENT_SIZE  ; edi indica event[i+1]
   dec ecx


   cmp ecx, 0
   jne bubble_sort


   ; la sfarsitul lui bubble_sort, daca edx este zero, se repeta compararea vectorului
   cmp edx, 0
   jne bubble_loop


   ; eliberez buffer temporar de pe stiva
   add esp, EVENT_SIZE


   ;; Your code ends here
   ;; DO NOT MODIFY


   popa
   leave
   ret


   ;; DO NOT MODIFY





