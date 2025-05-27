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
   .date: resb 4 ;1 (byte) + 1 (byte) + 2 (word) = 4 bytes
endstruc

section .data

section .text
   global check_events
   extern printf

check_events:
   ;; DO NOT MODIFY
   enter 0,0
   pusha

   mov ebx, [ebp + 8]  	; events
   mov ecx, [ebp + 12] 	; length
   ;; DO NOT MODIFY

   ;; Your code starts here

loop:
   cmp ecx, 0
   jle end_loop ;iesim din bucla daca ecx <= 0

   mov ax, word [ebx + event.date + date.year] ;anul
   mov dh, byte [ebx + event.date + date.month] ;luna
   mov dl, byte [ebx + event.date + date.day] ;ziua

   ;verificam daca anul este valid
   cmp ax, 1990
   jl invalid_date
   cmp ax, 2030
   jg invalid_date
 
   ;verificam daca luna este valida
   ;verificam daca ziua este valida
   ;aflam luna, intrucat pt fiecare luna avem nr diferit de zile
   cmp dh, 1
   je verify_31days
   cmp dh, 2
   je verify_february
   cmp dh, 3
   je verify_31days
   cmp dh, 4
   je verify_30days
   cmp dh, 5
   je verify_31days
   cmp dh, 6
   je verify_30days
   cmp dh, 7
   je verify_31days
   cmp dh, 8
   je verify_31days
   cmp dh, 9
   je verify_30days
   cmp dh, 10
   je verify_31days
   cmp dh, 11
   je verify_30days
   cmp dh, 12
   je verify_31days
   jmp invalid_date

;ianuarie, martie, mai, iulie, august, octombrie, decembrie
verify_31days:
   cmp dl, 1
   jl invalid_date
   cmp dl, 31
   jg invalid_date
   jmp valid_date

;aprilie, iunie, septembrie, noiembire
verify_30days:
   cmp dl, 1
   jl invalid_date
   cmp dl, 30
   jg invalid_date
   jmp valid_date

;februarie
verify_february:
   cmp dl, 1
   jl invalid_date
   cmp dl, 28
   jg invalid_date
   jmp valid_date

invalid_date:
   mov byte[ebx + event.valid], 0 ;setam validitatea 0
   jmp next_event

valid_date:
   mov byte[ebx + event.valid], 1 ;setam validitatea 1

next_event:
   add ebx, 36 ;trecem la urmatorul eveniment
   sub ecx, 1
   jmp loop

end_loop:
   ;; Your code ends here

   ;; DO NOT MODIFY
   popa
   leave
   ret
   ;; DO NOT MODIFY

