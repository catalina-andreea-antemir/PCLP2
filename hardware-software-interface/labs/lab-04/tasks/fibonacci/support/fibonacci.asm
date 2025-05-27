; SPDX-License-Identifier: BSD-3-Clause

%include "printf32.asm"

section .data
    N: dd 7          ; N-th fibonacci number to calculate

section .text
    global main
    extern printf

main:
    mov ecx, DWORD [N]       ; we want to find the N-th fibonacci number; N = ECX = 7
    PRINTF32 `%d\n\x0`, ecx  ; DO NOT REMOVE/MODIFY THIS LINE

    ; TODO: calculate the N-th fibonacci number (f(0) = 0, f(1) = 1)
    mov eax, 0
    mov ebx, 1
    cmp ecx, 0
    je special
    cmp ecx, 1
    je print
    sub ecx, 1

label:
    cmp ecx, 0
    jle print
    add eax, ebx
    mov edx, ebx
    mov ebx, eax
    mov eax, edx
    sub ecx, 1
    jmp label

special:
    PRINTF32 `%d\n\x0`, eax
    ret

print:
    PRINTF32 `%d\n\x0`, ebx 
    ret
