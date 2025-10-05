%include "../include/io.mac"
; declare your structs here
struc date
   .day: resb 1
   .month: resb 1
   .year: resw 1
endstruc

struc event
   .name: resb 31
   .valid: resb 1
   .date: resb 4 ;1 + 1 + 2
endstruc

section .text
   global sort_events
   extern printf

sort_events:
   ;; DO NOT MODIFY
   enter 0, 0
   pusha

   mov ebx, [ebp + 8]  	; events
   mov ecx, [ebp + 12] 	; length
   ;; DO NOT MODIFY

   ;; Your code starts here
   mov ebp, 0 ;index pt parcurgerea evenimentelor (i = 0)
out_loop:
   cmp ebp, ecx
   jge end_out_loop ;ne oprim cand i >= ecx
   mov edx, ebp

in_loop:
   add edx, 1 ;j = i + 1
   cmp edx, ecx
   jge end_in_loop ;ne oprim cand j >= ecx

   push ecx ;salvam lungimea

   ;calculam ev[i] = ebx + i * 36
   mov esi, ebp
   imul esi, 36
   add esi, ebx

   ;calculam ev[j] = ebx + j * 36
   mov edi, edx
   imul edi, 36
   add edi, ebx

   ;comparam validitatile (ev[i].valid cu ev[j].valid)
   mov al, byte [esi + event.valid]
   mov ah, byte [edi + event.valid]
   cmp al, ah
   jl swap ;daca ev[i].valid < ev[j].valid facem swap
   jg no_swap ;nu ne intereseaza cazul >, deci nu bagam in seama

   ;daca sunt egale
   ;comparam anii (ev[i].an cu ev[j].an)
   mov ax, word [esi + event.date + date.year]
   cmp ax, word [edi + event.date + date.year]
   jg swap ;daca ev[i].an > ev[j].an facem swap
   jl no_swap ;nu ne intereseaza cazul <, deci nu bagam in seama

   ;daca nu egali
   ;comparam lunile (ev[i].luna cu ev.[j].luna)
   mov al, byte [esi + event.date + date.month]
   mov ah, byte [edi + event.date + date.month]
   cmp al, ah
   jg swap ;daca ev[i].luna > ev[j].luna facem swap
   jl no_swap ;nu ne intereseaza cazul <, deci nu bagam in seama

   ;daca sunt egale
   ;comparam zilele (ev[i].zi cu ev[j].zi)
   mov al, byte [esi + event.date + date.day]
   mov ah, byte [edi + event.date + date.day]
   cmp al, ah
   jg swap ;daca ev[i].zi > ev[j].zi facem swap
   jl no_swap ;nu ne intereseaza cazul <, deci nu bagam in seama

   ;daca sunt egale
   ;comparam numele (ev[i].nume cu ev[j].nume)
   push esi ;salvam adresa lui ev[i]
   push edi ;salvam adresa lui ev[j]
   push ecx ;salvam ecx pt a l folosi ca index in parcurgerea numelor
   mov ecx, 0

compare_names:
   cmp ecx, 31
   jge end_compare_names ;daca am parcurs toti cei 31 de biti din nume ne oprim

   mov al, byte [esi + ecx + event.name] ;caracter din ev[i].name
   mov ah, byte [edi + ecx + event.name] ;caracter din ev[j].name
   cmp al, ah
   jne end_compare_names ;daca caracterele sunt diferite, iesim din bucla

   add ecx, 1 ;trecem la urmatorul caracter din nume
   jmp compare_names

end_compare_names:
   ;restauram lungimea si cele doua evenimente
   pop ecx
   pop edi
   pop esi
   jg swap ;dacă ev[i].name > ev[j].name facem swap
   jle no_swap ;nu ne intereseaza cazul <=, deci nu bagam in seama

no_swap:
   ;daca sunt egale, nu facem nimic
   pop ecx ;restauram lungimea si trecem la eveniment (ev[j+1])
   jmp in_loop

swap:
   ;ecx a fost salvat pe stiva in in_loop deci il putem folosi ca index
   mov ecx, 0

swap_loop:
   cmp ecx, 36
   jge end_swap_loop ;daca am facut swap la toti cei 36 de biti ne oprim

   ;facem swap pt fiecare bit din structura
   mov al, [esi + ecx]
   xchg al, [edi + ecx]
   mov [esi + ecx], al

   ;trecem la urmatorul bit
   add ecx, 1
   jmp swap_loop

end_swap_loop:
   pop ecx ;restauram lungimea si trecem la urmatorul eveniment (ev[j+1])
   jmp in_loop

end_in_loop:
   add ebp, 1 ;trecem la urmatorul eveniment (ev[i+1])
   jmp out_loop

end_out_loop:
   ;; Your code ends here

   ;; DO NOT MODIFY
   popa
   leave
   ret
   ;; DO NOT MODIFY
