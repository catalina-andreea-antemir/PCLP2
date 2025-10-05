%include "../include/io.mac"
extern printf
global remove_numbers


section .data
   fmt db "%d", 10, 0


section .text

; function signature:
; void remove_numbers(int *a, int n, int *target, int *ptr_len);
remove_numbers:
   ;; DO NOT MODIFY
   push	ebp
   mov 	ebp, esp
   pusha

   mov 	esi, [ebp + 8] ; source array
   mov 	ebx, [ebp + 12] ; n
   mov 	edi, [ebp + 16] ; dest array
   mov 	edx, [ebp + 20] ; pointer to dest length

   ;; DO NOT MODIFY
 
   ;; Your code starts here

   mov ecx, 0 ;indexul pentru a parcurge array ul
   mov eax, 0 ;contorul numerelor adaugate in dest array

loop:
   cmp ecx, ebx
   jge end_loop ;iesim din bucla daca ecx >= n
 
   ;SUBTASK 1
   ;verificam daca numerul este par sau impar
   mov ebp, [esi + ecx * 4] ;inmultirea cu 4 rezolta de la cei 4 bytes ai lui int
   test ebp, 1
   jnz is_odd

   ;SUBTASK 2
   ;verificam daca numarul este putere a lui 2 sau nu
   mov ebp, [esi + ecx * 4]
   sub ebp, 1
   and ebp, [esi + ecx * 4]
   jz is_power_of_2
 
   ;daca numarul e par sau nu e putere a lui 2 il adaugam in dest array
   mov ebp, [esi + ecx * 4]
   mov [edi + eax * 4], ebp
   add eax, 1 ;marim contorul pentru elementele adaugate in dest array

is_odd:
   add ecx, 1 ;trecem la urmatorul element
   jmp loop

is_power_of_2:
   add ecx, 1 ;trecem la urmatorul element
   jmp loop

end_loop:
   mov [edx], eax ;eax este egal cu nr de elemente adaugate in dest
              	;array deci edx trebuie sa aiba aceeasi valoare
   ;; Your code ends here
 
   ;; DO NOT MODIFY

   popa
   leave
   ret

   ;; DO NOT MODIFY
