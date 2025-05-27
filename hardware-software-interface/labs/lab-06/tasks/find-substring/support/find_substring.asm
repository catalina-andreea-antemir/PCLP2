; SPDX-License-Identifier: BSD-3-Clause

%include "printf32.asm"

section .data
source_text: db "ABCABCBABCBABCBBBABABBCBABCBAAACCCB", 0 ; DO NOT MODIFY THIS LINE EXCEPT FOR THE STRING IN QUOTES
substring: db "BABC", 0 ; DO NOT MODIFY THIS LINE EXCEPT FOR THE STRING IN QUOTES

print_format: db "Substring found at index: %d", 10, 0

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    ; TODO: Print the start indices for all occurrences of the substring in source_text
    mov eax, 1
look:
    cmp dword [source_text + eax * 4], 0
    je end
    mov ebx, [source_text + eax * 4]
    cmp [substring], ebx
    je found
    add ebx, 1
    jmp look

found:
    sub ebx, 1
    PRINTF32 `Substring found at index: %hhu\n\x0`, ebx
    add ebx, 2
    jmp look

 end:   
    leave
    ret
