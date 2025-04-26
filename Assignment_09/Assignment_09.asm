.386
.model flat,stdcall
.stack 4096

INCLUDE Irvine32.inc

.data
X       SDWORD  ?

msg1    BYTE    "A + B - C = ",0
plus    BYTE    " + ",0
equals  BYTE    " = ",0

; Inputs for ArithmeticExpression
A1      SDWORD  10
B1      SDWORD  20
C1      SDWORD   5

; Buffers for BCD addition tests
num1a   DB      78h,56h,34h,12h    ; 12345678
num2a   DB      21h,43h,65h,87h    ; 87654321
res1    DD      0

num1b   DB      11h,22h,33h,44h    ; 44332211
num2b   DB      55h,66h,77h,88h    ; 88776655
res2    DD      0

num1c   DB      99h,88h,77h,66h    ; 66778899
num2c   DB      01h,02h,03h,04h    ; 04030201
res3    DD      0

.code
main PROC
    ; Compute X = A + B - C
    push C1
    push B1
    push A1
    call ArithmeticExpression
    mov edx, OFFSET msg1
    call WriteString
    mov eax, [EDI]
    call WriteDec
    call Crlf

    ; BCD addition tests
    ; Test 1
    mov esi, OFFSET num1a
    mov edi, OFFSET num2a
    mov ebx, OFFSET res1
    call AddBCD

    mov eax, DWORD PTR [num1a]
    call WriteHex
    mov edx, OFFSET plus
    call WriteString
    mov eax, DWORD PTR [num2a]
    call WriteHex
    mov edx, OFFSET equals
    call WriteString
    mov eax, DWORD PTR [res1]
    call WriteHex
    call Crlf

    ; Test 2
    mov esi, OFFSET num1b
    mov edi, OFFSET num2b
    mov ebx, OFFSET res2
    call AddBCD

    mov eax, DWORD PTR [num1b]
    call WriteHex
    mov edx, OFFSET plus
    call WriteString
    mov eax, DWORD PTR [num2b]
    call WriteHex
    mov edx, OFFSET equals
    call WriteString
    mov eax, DWORD PTR [res2]
    call WriteHex
    call Crlf

    ; Test 3
    mov esi, OFFSET num1c
    mov edi, OFFSET num2c
    mov ebx, OFFSET res3
    call AddBCD

    mov eax, DWORD PTR [num1c]
    call WriteHex
    mov edx, OFFSET plus
    call WriteString
    mov eax, DWORD PTR [num2c]
    call WriteHex
    mov edx, OFFSET equals
    call WriteString
    mov eax, DWORD PTR [res3]
    call WriteHex
    call Crlf

    invoke ExitProcess, 0
main ENDP

ArithmeticExpression PROC C
    push ebp
    mov  ebp, esp
    mov  eax, [ebp+8]
    add  eax, [ebp+12]
    sub  eax, [ebp+16]
    mov  X, eax
    lea  edi, X
    pop  ebp
    ret  12
ArithmeticExpression ENDP

AddBCD PROC
    push ebp
    mov  ebp, esp
    clc
    mov  ecx, 4
LoopBCD:
    mov  al, [esi]
    adc  al, [edi]
    daa
    mov  [ebx], al
    inc  esi
    inc  edi
    inc  ebx
    loop LoopBCD
    pop  ebp
    ret
AddBCD ENDP

END main