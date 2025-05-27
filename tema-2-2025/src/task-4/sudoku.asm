%include "../include/io.mac"

extern printf
global check_row
global check_column
global check_box
; you can declare any helper variables in .data or .bss

section .data
   visited resb 10 ;vector de frecventa pentru cifrele de la 1 la 9


section .text

; int check_row(char* sudoku, int row);
check_row:
   ;; DO NOT MODIFY
	push	ebp
	mov 	ebp, esp
	push ebx
	push ecx
	push edx
	push esi
	push edi

	mov 	esi, [ebp + 8]  ; char* sudoku, pointer to 81-long char array
	mov 	edx, [ebp + 12]  ; int row
	;; DO NOT MODIFY
    
	;; Freestyle starts here
	mov ecx, 0 ;index pt parcurgere vector de fracventa
row_clear_visited:
	cmp ecx, 10
	jge verify_row ;daca am setat frecventa fiecarei cifre la 0 ne oprim
	mov byte [visited + ecx], 0 ;setam frecventa fiecarei cifre la 0
	add ecx, 1
	jmp row_clear_visited

verify_row:
	mov ebx, 0 ;index coloane
row_loop:
	cmp ebx, 9
	jge verify_freq_row ;daca am parcurs toate cifrele iesim din functie

	mov eax, edx ;row
	imul eax, 9 ;row * 9
	add eax, ebx ;row * 9 + i
	movzx eax, byte [esi + eax]

	;verificam daca cifra e in intervalul 1-9
	cmp eax, 1
	jl row_not_ok
	cmp eax, 9
	jg row_not_ok
	cmp byte [visited + eax], 0 ;verificam daca cifra a fost deja vizitata
	jne row_not_ok
	mov byte [visited + eax], 1 ;marcam cifra ca vizitata
	add ebx, 1
	jmp row_loop

verify_freq_row:
	mov ebx, 1
row_freq_loop:
	cmp ebx, 10
	jge row_ok
	cmp byte [visited + ebx], 1 ;verificam daca cifra a fost vizitata
	jne row_not_ok
	add ebx, 1
	jmp row_freq_loop

row_ok:
	mov eax, 1
	jmp end_check_row ;iesim din functie

row_not_ok:
	mov eax, 2
	jmp end_check_row ;iesim din functie

   ;; MAKE SURE TO LEAVE YOUR RESULT IN EAX BY THE END OF THE FUNCTION
   ;; Remember: OK = 1, NOT_OKAY = 2
   ;; ex. if this row is okay, by this point eax should contain the value 1

   ;; Freestyle ends here
end_check_row:
   ;; DO NOT MODIFY

	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	leave
	ret
    
   ;; DO NOT MODIFY

; int check_column(char* sudoku, int column);
check_column:
   ;; DO NOT MODIFY
   push	ebp
   mov 	ebp, esp
   push ebx
   push ecx
   push edx
   push esi
   push edi

   mov 	esi, [ebp + 8]  ; char* sudoku, pointer to 81-long char array
   mov 	edx, [ebp + 12]  ; int column
   ;; DO NOT MODIFY
 
   ;; Freestyle starts here
	mov ecx, 0 ;index pt parcurgere vector de fracventa
col_clear_visited:
	cmp ecx, 10
	jge verify_col ;daca am setat frecventa fiecarei cifre la 0 ne oprim
	mov byte [visited + ecx], 0 ;setam frecventa fiecarei cifre la 0
	add ecx, 1
	jmp col_clear_visited

verify_col:
	mov ebx, 0 ;index linii
col_loop:
	cmp ebx, 9
	jge verify_freq_col ;daca am parcurs toate cifrele iesim din functie

	mov eax, ebx ;col
	imul eax, 9 ;col * 9
	add eax, edx ;col * 9 + i
	movzx eax, byte [esi + eax]

	;verificam daca cifra e in intervalul 1-9
	cmp eax, 1
	jl col_not_ok
	cmp eax, 9
	jg col_not_ok
	cmp byte [visited + eax], 0 ;verificam daca cifra a fost deja vizitata
	jne col_not_ok
	mov byte [visited + eax], 1 ;marcam cifra ca vizitata
	add ebx, 1
	jmp col_loop

verify_freq_col:
	mov ebx, 1
col_freq_loop:
	cmp ebx, 10
	jge col_ok
	cmp byte [visited + ebx], 1 ;verificam daca cifra a fost vizitata
	jne col_not_ok
	add ebx, 1
	jmp col_freq_loop

col_ok:
	mov eax, 1
	jmp end_check_column ;iesim din functie

col_not_ok:
	mov eax, 2
	jmp end_check_column ;iesim din functie

   ;; MAKE SURE TO LEAVE YOUR RESULT IN EAX BY THE END OF THE FUNCTION
   ;; Remember: OK = 1, NOT_OKAY = 2
   ;; ex. if this column is okay, by this point eax should contain the value 1

   ;; Freestyle ends here
end_check_column:
   ;; DO NOT MODIFY

   pop edi
   pop esi
   pop edx
   pop ecx
   pop ebx
   leave
   ret
 
    ;; DO NOT MODIFY

; int check_box(char* sudoku, int box);
check_box:
   ;; DO NOT MODIFY
   push	ebp
   mov 	ebp, esp
   push ebx
   push ecx
   push edx
   push esi
   push edi

   mov 	esi, [ebp + 8]  ; char* sudoku, pointer to 81-long char array
   mov 	edx, [ebp + 12]  ; int box
   ;; DO NOT MODIFY
 
   ;; Freestyle starts here
	mov ecx, 0 ;index pt parcurgere vector de fracventa
box_clear_visited:
	cmp ecx, 10
	jge verify_box ;daca am setat frecventa fiecarei cifre la 0 ne oprim
	mov byte [visited + ecx], 0 ;setam frecventa fiecarei cifre la 0
	add ecx, 1
	jmp box_clear_visited

verify_box:
	mov eax, edx ;box
	mov edx, 0 ;golim edx pt instructiunea div
	mov ebx, 3
	div ebx ;box_row = box / 3 si box_col = box % 3
	imul eax, 3 ;box_row = (box / 3) * 3
	imul edx, 3 ;box_col = (box % 3) * 3

	mov ecx, 0 ;i = 0
box_row_loop:
	cmp ecx, 3
	jge verify_freq_box ;daca am parcurs toate cifrele iesim din functie

	mov ebx, 0 ;j = 0
box_col_loop:
	cmp ebx, 3
	jge end_box_col_loop ;daca ebx >= 3 iesim din bucla

	mov edi, eax ;box_row
	add edi, ecx ;box_row + i
	imul edi, 9 ;(box_row + i) * 9
	add edi, edx ;(box_row + i) * 9 + box_col
	add edi, ebx ;(box_row + i) * 9 + box_col + j
	push eax ;salvam box_row
	movzx eax, byte [esi + edi]

	;verificam daca cifra e in intervalul 1-9
	cmp eax, 1
	jl box_pop_and_not_ok
	cmp eax, 9
	jg box_pop_and_not_ok
	cmp byte [visited + eax], 0 ;verificam daca cifra a fost deja vizitata
	jne box_pop_and_not_ok
	mov byte [visited + eax], 1 ;marcam cifra ca vizitata
	add ebx, 1 ;j++
	pop eax
	jmp box_col_loop

box_pop_and_not_ok:
	pop eax ;restauram box_row
	jmp box_not_ok

end_box_col_loop:
	add ecx, 1 ;i++
	jmp box_row_loop

verify_freq_box:
	mov ebx, 1
box_freq_loop:
	cmp ebx, 10
	jge box_ok
	cmp byte [visited + ebx], 1 ;verificam daca cifra a fost vizitata
	jne box_not_ok
	add ebx, 1
	jmp box_freq_loop

box_ok:
	mov eax, 1
	jmp end_check_box ;iesim din functie

box_not_ok:
	mov eax, 2
	jmp end_check_box ;iesim din functie

   ;; MAKE SURE TO LEAVE YOUR RESULT IN EAX BY THE END OF THE FUNCTION
   ;; Remember: OK = 1, NOT_OKAY = 2
   ;; ex. if this box is okay, by this point eax should contain the value 1

   ;; Freestyle ends here
end_check_box:
   ;; DO NOT MODIFY

   pop edi
   pop esi
   pop edx
   pop ecx
   pop ebx
   leave
   ret
 
   ;; DO NOT MODIFY
