; SPDX-License-Identifier: BSD-3-Clause

%include "printf32.asm"

%define ARRAY_SIZE    10

section .data
    byte_array db 8, 19, 12, 3, 6, 200, 128, 19, 78, 102
    word_array dw 1893, 9773, 892, 891, 3921, 8929, 7299, 720, 2590, 28891
    dword_array dd 1392849, 12544, 879923, 8799279, 7202277, 971872, 28789292, 17897892, 12988, 8799201
    dword_array2 dd 1392, 12544, 7992, 6992, 7202, 27187, 28789, 17897, 12988, 17992 ; for squares
    big_numbers_array dd 20000001, 3000000, 3000000, 23456789, 56789123, 123456789, 987654321, 56473829, 87564836, 777777777
    ; HINT: define two variables for the big_numbers_sum

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    mov ecx, ARRAY_SIZE     ; Use ecx as loop counter.
    xor eax, eax            ; Use eax to store the sum.
    xor edx, edx            ; Store current value in dl; zero entire edx.

add_byte_array_element:
    mov dl, byte [byte_array + ecx - 1]
    add eax, edx
    loop add_byte_array_element ; Decrement ecx, if not zero, add another element.

    PRINTF32 `Array sum is %u\n\x0`, eax

    ; TODO: Compute sum for elements in word_array and dword_array.
    mov ecx, ARRAY_SIZE
    xor eax, eax
sum_word:
    mov dx, word [word_array + (ecx - 1) * 2]
    add eax, edx
    loop sum_word

    PRINTF32 `Array sum is %u\n\x0`, eax

    mov ecx, ARRAY_SIZE
    xor eax, eax
sum_dword:
    mov edx, dword [dword_array + (ecx - 1) * 4]
    add eax, edx
    loop sum_dword

    PRINTF32 `Array sum is %u\n\x0`, eax

    ; TODO: Compute the sum of squares for elements in dword_array2
    mov ecx, ARRAY_SIZE
    xor eax, eax
sum_sq_dword:
    mov edx, dword [dword_array2 + (ecx - 1) * 4]
    imul edx, edx
    add eax, edx
    loop sum_sq_dword

    PRINTF32 `Array sum is %u\n\x0`, eax

    ; TODO: Compute the sum of squares for elements in big_numbers_array
    mov ecx, ARRAY_SIZE
    xor eax, eax
sum_sq_big_dword:
    
    PRINTF32 `Array sum is %u\n\x0`, eax

    leave
    ret
