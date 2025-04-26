TITLE XOR Encryption/Decryption Program          ; Program title
INCLUDE Irvine32.inc                             ; Include Irvine32 library

.data                                            ; Data segment
    PlainText   BYTE "Hodges", 0                 ; Plain text
    CipherText  BYTE 8 DUP(0)                    ; Buffer for cipher text (same length)
    DecodedText BYTE 8 DUP(0)                    ; Buffer for decoded text (same length)
    MsgPlain    BYTE "Plain text: ", 0           ; Message for plain text output
    MsgCipher   BYTE "Cipher text: ", 0          ; Message for cipher text output
    MsgDecoded  BYTE "Decoded text: ", 0         ; Message for decoded text output
    Key         BYTE 17                          ; XOR key (last two digits of student ID: 17)

.code                                            ; Code segment
main PROC                                        ; Main procedure start
    mov edx, OFFSET MsgPlain                     ; Load plain text message address
    call WriteString                             ; Print plain text message
    mov edx, OFFSET PlainText                    ; Load plain text address
    call WriteString                             ; Print plain text
    call Crlf                                    ; New line
    lea esi, PlainText                           ; Point ESI to plain text
    lea edi, CipherText                          ; Point EDI to cipher text buffer

EncryptLoop:                                     ; Begin encryption loop
    mov al, [esi]                                ; Load byte from plain text into AL
    cmp al, 0                                    ; Check for end-of-string (null)
    je EncryptDone                               ; Jump if end-of-string
    xor al, Key                                  ; XOR AL with key for encryption
    mov [edi], al                                ; Store result in cipher text buffer
    inc esi                                      ; Move to next plain text byte
    inc edi                                      ; Move to next cipher text byte
    jmp EncryptLoop                              ; Repeat loop

EncryptDone:                                     ; End of encryption loop
    mov byte ptr [edi], 0                        ; Append null terminator to cipher text
    mov edx, OFFSET MsgCipher                    ; Load cipher text message address
    call WriteString                             ; Print cipher text message
    mov edx, OFFSET CipherText                   ; Load cipher text address
    call WriteString                             ; Print cipher text (may appear garbled)
    call Crlf                                    ; New line
    lea esi, CipherText                          ; Point ESI to cipher text
    lea edi, DecodedText                         ; Point EDI to decoded text buffer

DecryptLoop:                                     ; Begin decryption loop
    mov al, [esi]                                ; Load byte from cipher text into AL
    cmp al, 0                                    ; Check for end-of-string (null)
    je DecryptDone                               ; Jump if end-of-string
    xor al, Key                                  ; XOR AL with key to decrypt
    mov [edi], al                                ; Store result in decoded text buffer
    inc esi                                      ; Move to next cipher text byte
    inc edi                                      ; Move to next decoded text byte
    jmp DecryptLoop                              ; Repeat loop

DecryptDone:                                     ; End of decryption loop
    mov byte ptr [edi], 0                        ; Append null terminator to decoded text
    mov edx, OFFSET MsgDecoded                   ; Load decoded text message address
    call WriteString                             ; Print decoded text message
    mov edx, OFFSET DecodedText                  ; Load decoded text address
    call WriteString                             ; Print decoded text (should match plain text)
    call Crlf                                    ; New line

    exit                                         ; Exit the program
main ENDP                                        ; End main procedure
END main                                         ; End of file