;	161663_3.asm

INCLUDE irvine32.inc
BUFMAX = 40

.386
.model flat, stdcall
.stack 4096
ExitProcess Proto, dwExitCode:DWORD

.data
found			BYTE	1
nfound			BYTE	0
isFound			BYTE	0
endWord			BYTE	0
none			DWORD	0;	input nothing

sTypeString		BYTE	"Type_A_String: ", 0

;
; sString			BYTE	"String: ", 0
; sTarget			BYTE	"Target: ", 0
;

sTypeTarget		BYTE	"A_Word_for_Search: ", 0
sChanged		BYTE	"Changed: ", 0
sFound			BYTE	"Found", 0
sNotFound		BYTE	"Not found", 0
sEnd			BYTE	"Bye!", 0

buffer			BYTE	BUFMAX + 1 DUP(0)
target			BYTE	BUFMAX + 1 DUP(0)
changed			BYTE	BUFMAX + 1 DUP(' ')
space			BYTE	' '

bufSize			DWORD ?
tarSize			DWORD ?

bIdx			DWORD 0
tIdx			DWORD 0
tStart			DWORD 0
tEnd			DWORD 0

.code
main PROC

INPUT :
mov edx, OFFSET sTypeString
call WriteString
mov ecx, BUFMAX
mov edx, OFFSET buffer
call ReadString

cmp eax, none
je ENDLABEL

mov bufSize, eax

mov edx, OFFSET sTypeTarget
call WriteString
mov ecx, BUFMAX
mov edx, OFFSET target
call ReadString

cmp eax, none
je ENDLABEL

mov tarSize, eax

call FindTarget

movzx eax, isFound
cmp al, found
je PRINT_FOUND

mov edx, OFFSET sNotFound
call WriteString
call Crlf
jmp INPUT

PRINT_FOUND:
mov edx, OFFSET sFound
call WriteString
call Crlf

call ResetString

call MakeChangedString

mov edx, OFFSET sChanged
call WriteString
mov edx, OFFSET changed
call WriteString
call Crlf

jmp INPUT

ENDLABEL :
mov edx, OFFSET sEnd
call WriteString
INVOKE ExitProcess, 0
main ENDP

; ------------------------------------------------------------------------------
FindTarget PROC
; ------------------------------------------------------------------------------

mov isFound, 0
mov bIdx, 0
mov tIdx, 0
mov ecx, bufSize
inc ecx

L1:
mov esi, bIdx
mov al, buffer[esi]
mov esi, tIdx
mov bl, target[esi]

cmp al, bl
je BOTH_INC

BUF_INC:
add bIdx, 1
mov tIdx, 0
jmp NO

BOTH_INC:
add bIdx, 1
add tIdx, 1

mov eax, tarSize
cmp tIdx, eax
jne NO

mov esi, bIdx
mov bl, buffer[esi]

cmp bl, space
je YES
cmp bl, endWord
je YES

NO:
loop L1

jmp ENDL

YES:
mov ebx, bIdx
mov tEnd, ebx
dec tEnd
mov ebx, tEnd
mov tStart, ebx
mov ebx, tarSize
sub tStart, ebx
inc tStart
mov isFound, 1

ENDL:
ret
FindTarget ENDP

; ------------------------------------------------------------------------------
ResetString PROC
; ------------------------------------------------------------------------------
mov ecx, BUFMAX
mov esi, 0
L1:
mov al, space
mov changed[esi], al
inc esi
loop L1
mov changed[esi], 0

ret
ResetString ENDP

; ------------------------------------------------------------------------------
MakeChangedString PROC
; ------------------------------------------------------------------------------
mov ecx, tStart
mov esi, 0
mov edi, 0

cmp ecx, none
je ENDL1

L1:
mov al, buffer[esi]
mov changed[edi], al
inc esi
inc edi
loop L1

ENDL1:
mov ecx, bufSize
sub ecx, tEnd
dec ecx
mov esi, tEnd
inc esi

cmp ecx, none
je ENDL2
L2:
mov al, buffer[esi]
mov changed[edi], al
inc esi
inc edi
loop L2

ENDL2:

ret
MakeChangedString ENDP

END main
