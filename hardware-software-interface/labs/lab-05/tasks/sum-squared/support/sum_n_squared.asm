; SPDX-License-Identifier: BSD-3-Clause

%include "printf32.asm"

section .data
    num dd 100

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    mov ecx, [num]     ; Use ecx as counter for computing the sum.
    xor eax, eax       ; Use eax to store the sum. Start from 0.

sq_sum:
    push eax
    mov eax, ecx
    mul eax
    mov ebx, eax
    pop eax
    add eax, ebx
    loop sq_sum
    
    mov ecx, [num]
    PRINTF32 `Sum(%u): %u\n\x0`, ecx, eax

    leave
    ret
