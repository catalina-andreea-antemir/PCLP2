; SPDX-License-Identifier: BSD-3-Clause

%include "printf32.asm"

section .bss
    array3: resw 10

section .data
    array1: db 27, 35, 46, 14, 17, 29, 37, 104, 135, 124
    array2: db 15, 38, 44, 20, 17, 33, 78, 143, 132, 16

section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp
    ; TODO: Traversing array1 and array2 and putting the result in array3

    xor ebx, ebx ;index
mul_elem:
    cmp ebx, 10
    jge end
    mov al, [array1 + ebx]
    mov cl, [array2 + ebx]
    mul cl
    mov [array3 + ebx * 2], ax
    add ebx, 1
    jmp mul_elem

end:
    PRINTF32 `The array that results from the product of the corresponding elements in array1 and array2 is:\n\x0`
    ; TODO: Traversing array3 and displaying its elements

    xor ebx, ebx
print_elem:
    cmp ebx, 10
    je finish
    mov eax, [array3 + ebx * 2]
    PRINTF32 `%hu \x0`, eax
    add ebx, 1
    jmp print_elem

finish:
    PRINTF32 `\n\x0`
    leave
    ret
