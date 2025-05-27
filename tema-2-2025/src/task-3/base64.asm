%include "../include/io.mac"
extern printf
global base64

section .data
   alphabet db 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
   fmt db "%d", 10, 0

section .text

base64:
   ;; DO NOT MODIFY

   push ebp
   mov ebp, esp
   pusha

   mov esi, [ebp + 8] ; source array
   mov ebx, [ebp + 12] ; n
   mov edi, [ebp + 16] ; dest array
   mov edx, [ebp + 20] ; pointer to dest length

   ;; DO NOT MODIFY

   ; -- Your code starts here --
   mov ecx, 0 ;index parcugere array
   mov eax, 0 ;contor pt lungimea lui dest array


loop:
   cmp ecx, ebx
   jge end_loop ;iesim din bucla daca ecx >= n

   push eax ;pastram pe stiva valoaea lui eax pt a putea refolosi registrul
 
   ;ebp cintine primii 8 biti (23 - 16)
   movzx ebp, byte [esi + ecx] ;byte1
   shl ebp, 16
   ;eax contine urmatorii 8 biti (15 - 8)
   movzx eax, byte [esi + ecx + 1] ;byte2
   shl eax, 8
   or ebp, eax ;ebp contine cei 16 biti de pana acum concatenati
   ;eax contine ulrimii 8 biti (7 - 0)
   movzx eax, byte [esi + ecx + 2] ;byte3
   or ebp, eax ;ebp contine toti cei 24 biti concatenati

   push ecx ;pastram pe stiva valoarea indexului pt a putea refolosi registrul

   mov eax, ebp
   shr eax, 18 ;pastram in eax primii 6 biti
   shl eax, 26
   shr eax, 26 ;mutam primul grup de 6 biti pe pozitiile 5-0 si ii izolam
   ;adaugam primul caracter reprezentat de primii 6 biti in dest array
   mov cl, [alphabet + eax]
   mov [edi], cl
   add edi, 1 ;mutam poiterul la urmatoarea pozitie

   mov eax, ebp
   shr eax, 12 ;pastrat in eax urmatorii 6 biti
   shl eax, 26
   shr eax, 26 ;mutam urmatorul grup de 6 bitii pe pozitiile 5-0 si ii izolam
   ;adaugam urmatorul caracter (al doilea grup de 6 biti in dest array)
   mov cl, [alphabet + eax]
   mov [edi], cl
   add edi, 1 ;mutam poiterul la urmatoarea pozitie

   mov eax, ebp
   shr eax, 6 ;pastram in eax urmatorii 6 biti
   shl eax, 26
   shr eax, 26 ;mutam urmatorul grup de 6 biti pe pozitiile 5-0 si ii izolam
   ;adaugam urmatorul caracter (al treilea grup de 6 biti in dest array)
   mov cl, [alphabet + eax]
   mov [edi], cl
   add edi, 1 ;mutam pointerul la urmatoarea pozitie

   mov eax, ebp
   shl eax, 26
   shr eax, 26 ;izolam ultimii 6 biti care deja se afla pe pozitiile 5-0
   ;adaugam urmatorul caraccter (ultimul grup de 6 biti in dest array)
   mov cl, [alphabet + eax]
   mov [edi], cl
   add edi, 1 ;mutam poiterul la urmatoarea pozitie

   pop ecx ;restauram indexul
   add ecx, 3 ;incrementam indexul cu 3 pt urmatorii 3 octeti
   pop eax ;restauram contorul
   add eax, 4 ;ncrementam cu 4 pt cele 4 caractere scrie in dest array
   jmp loop

end_loop:
   mov [edx], eax ;actualizam lungimea lui dest array
   ; -- Your code ends here --

   ;; DO NOT MODIFY

   popa
   leave
   ret

   ;; DO NOT MODIFY
