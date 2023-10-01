global start  ; export label for program entry point

section .text ; define section
bits 32       ; specify 32bit instructions
start:
    ; print `OK` to screen
    mov dword [0xb8000], 0x2f4b2f4f
    hlt       ; cpu stop
