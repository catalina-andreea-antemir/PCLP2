; SPDX-License-Identifier: BSD-3-Clause

%include "printf32.asm"

%define ARRAY_SIZE    10

section .data
    dword_array dd 1392, -12544, -7992, -6992, 7202, 27187, 28789, -17897, 12988, 17992

section .text
extern printf
global main
main:
	; TODO: Implement the code to count negative and positive numbers in the array

    mov ecx, ARRAY_SIZE
    xor eax, eax ;negative
    xor ebx, ebx ;pozitive

array:
    cmp ecx, 0
    je end

    mov edi, ecx
    sub edi, 1
    shl edi, 2
    mov edx, [dword_array + edi]
    
    cmp edx, 0
    jl negative

    sub ecx, 1
    add ebx, 1
    jmp array
    
negative:
    sub ecx, 1
    add eax, 1
    jmp array

end:
    PRINTF32 `gibberish (text) "%u" gibberish (text / spaces) "%u\n\x0"`, ebx, eax
    ret
