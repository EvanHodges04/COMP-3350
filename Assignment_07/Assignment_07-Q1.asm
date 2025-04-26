TITLE Character Search Program (1-Based Indexing)       ; Program title
INCLUDE Irvine32.inc                                    ; Include Irvine32 library

.data                                                   ; Data segment start
    MyString    BYTE "Spring is pleasant in Auburn", 0  ; String to search (null-terminated)
    MsgFound    BYTE "Character found: ", 0             ; Message if found
    MsgAtIndex  BYTE " at index: ", 0                   ; Message preceding index output
    MsgNotFound BYTE "Character not found", 0           ; Message if not found

.code                                                   ; Code segment start
main PROC                                               ; Main procedure start
    mov al, 'x'                                         ; Set search character ('t')
    mov ecx, 0                                          ; Initialize index counter to 0
    mov esi, OFFSET MyString                            ; Point ESI to start of MyString

SearchLoop:                                             ; Begin search loop
    mov bl, [esi]                                       ; Load current character into BL
    cmp bl, 0                                           ; Check if end-of-string (null)
    je NotFound                                         ; Jump if null terminator found
    inc ecx                                             ; Increment index counter (1-based)
    cmp bl, al                                          ; Compare current char with search char
    je Found                                            ; Jump if character matches
    inc esi                                             ; Move to next character
    jmp SearchLoop                                      ; Loop back for next character

Found:                                                  ; Character found branch
    mov edx, OFFSET MsgFound                            ; Load address of "Character found: "
    call WriteString                                    ; Print "Character found: "
    mov dl, al                                          ; Move found character to DL
    call WriteChar                                      ; Print the found character
    mov edx, OFFSET MsgAtIndex                          ; Load address of " at index: "
    call WriteString                                    ; Print " at index: "
    mov eax, ecx                                        ; Move index into EAX
    call WriteDec                                       ; Print the index as decimal
    call Crlf                                           ; Print newline
    jmp EndProgram                                      ; Jump to program end

NotFound:                                               ; Character not found branch
    mov edx, OFFSET MsgNotFound                         ; Load address of "Character not found"
    call WriteString                                    ; Print "Character not found"
    call Crlf                                           ; Print newline

EndProgram:                                             ; End of program
    exit                                                ; Exit the program
main ENDP                                               ; End of main procedure
END main                                                ; End of file