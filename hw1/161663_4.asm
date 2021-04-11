;	Copy a String in Reverse Order(161663_4.asm)

INCLUDE irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess Proto, dwExitCode:DWORD

.data
INCLUDE hw4.inc

.code
main PROC
mov esi, SIZEOF source - 2								;	index register for target string
mov edi, 0												;	index register for source string	
mov ecx, SIZEOF source - 1								;	loop counter

L1 :
mov al, source[edi]										; get a character from source

mov target[esi], al										; store it in the target reversely
inc edi													; move to next character in source string
dec esi													; move to next position to store in target string
loop L1													; repeat for entire string except null character

mov target[SIZEOF source - 1], 0						; store null character in the end of target string
mov edx, OFFSET target									; store offset of target string in register
call WriteString										; print target string on console

INVOKE ExitProcess, 0
main ENDP
END main