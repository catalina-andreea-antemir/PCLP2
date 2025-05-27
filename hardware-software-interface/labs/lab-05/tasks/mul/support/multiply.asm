; SPDX-License-Identifier: BSD-3-Clause

%include "printf32.asm"

; https://en.wikibooks.org/wiki/X86_Assembly/Arithmetic

section .data
    num1 db 43
    num2 db 39
    num1_w dw 1349
    num2_w dw 9949
    num1_d dd 134932
    num2_d dd 994912

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    ; Multiplication for db
    mov al, byte [num1]
    mov bl, byte [num2]
    mul bl

    ; Print result in hexa
    PRINTF32 `Result is: 0x%hx\n\x0`, eax


    ; TODO: Implement multiplication for dw and dd data types.
    xor eax, eax
    xor ebx, ebx
    xor edx, edx
    mov ax, word [num1_w]
    mov bx, word [num2_w]
    mul bx
    PRINTF32 `Result is: 0x%hx%hx\n\x0`, edx, eax

    xor eax, eax
    xor edx, edx
    xor ebx, ebx
    mov eax, dword [num1_d]
    mov ebx, dword [num2_d]
    mul ebx
    PRINTF32 `Result is: 0x%x%x\n\x0`, edx, eax

    

    leave
    ret
