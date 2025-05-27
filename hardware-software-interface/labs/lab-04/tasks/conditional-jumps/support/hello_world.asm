; SPDX-License-Identifier: BSD-3-Clause

%include "printf32.asm"

section .data
    myString: db "Hello, World!", 0
    myString2: db "Goodbye, World!", 0
    N: dd 6                         ; N = 6

section .text
    global main
    extern printf

main:
    mov ecx, DWORD [N]              ; ecx will store the value of N
    PRINTF32 `%d\n\x0`, ecx         ; DO NOT REMOVE/MODIFY THIS LINE

    mov eax, 2
    mov ebx, 1
    cmp eax, ebx
    jg print                        ; TODO1: eax > ebx?
    ret

print:
    sub ecx, 1
    PRINTF32 `%s\n\x0`, myString
    cmp ecx, 0                                ; TODO2.2: print "Hello, World!" N times
    jle end                                ; TODO2.1: print "Goodbye, World!"
    jmp print

end:
    PRINTF32 `%s\n\x0`, myString2
    ret
