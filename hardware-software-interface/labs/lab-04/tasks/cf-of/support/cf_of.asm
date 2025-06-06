; SPDX-License-Identifier: BSD-3-Clause

%include "printf32.asm"

section .text
    global main
    extern printf

main:
    mov al, 128
    PRINTF32 `the Carry Flag and the Overflow Flag are not active\n\x0`
    test al, al
    ;TODO: activate the Carry Flag and the Overflow Flag
    add al, 129
    jc cf_on
    jmp end

cf_on:
    jo cf_of_on
    jmp end

cf_of_on:
    PRINTF32 `the Carry Flag and the Overflow Flag are active\n\x0`

end:
    ret

