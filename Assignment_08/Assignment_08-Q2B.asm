.386
.model flat,stdcall
.stack 4096

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data
promptDH  BYTE "DH = 0x",0
promptDL  BYTE "DL = 0x",0
saveDH    BYTE ?
saveDL    BYTE ?

.code
main PROC

    mov  eax, 0B56CA2E9h

    mov dh, 56h 
    mov dl, 29h

    mov saveDH, dh
    mov saveDL, dl

    mov edx, OFFSET promptDH
    call WriteString

    mov al, saveDH
    movzx eax, al
    call WriteHex
    call Crlf

    mov edx, OFFSET promptDL
    call WriteString

    mov al, saveDL
    movzx eax, al
    call WriteHex
    call Crlf

    invoke ExitProcess, 0
main ENDP
END main