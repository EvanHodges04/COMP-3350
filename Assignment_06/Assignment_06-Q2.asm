TITLE Stack Input/Output (main.asm)
INCLUDE Irvine32.inc

.data
PromptUser BYTE "Please enter a value: ", 0

.code
main PROC

    mov ecx, 4
input_loop:

    mov edx, OFFSET PromptUser
    call WriteString

    call ReadInt

    push eax

    loop input_loop

    mov ecx, 4
output_loop:
    pop eax
    call WriteInt
    call Crlf
    loop output_loop

    exit
main ENDP

END main