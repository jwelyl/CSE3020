;	161663_2.asm

INCLUDE irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess Proto, dwExitCode:DWORD

.data
sMultiplier		BYTE	"Enter a Multiplier : ", 0
sMultiplicand	BYTE	"Enter a Multiplicand : ", 0
sProduce		BYTE	"Produce : ", 0
sEnd			BYTE	"Bye!", 0

none	DWORD 0;	input nothing
left	DWORD ? ;	multiplier
right	DWORD ? ;	multiplicand
result	DWORD ? ;	produce
expon	BYTE ? ;	exponent

.code
main PROC

input :
mov result, 0
mov edx, OFFSET sMultiplier
call WriteString
call ReadHex
mov left, eax

cmp eax, none
je ENDLABEL

mov edx, OFFSET sMultiplicand
call WriteString
call ReadHex
mov right, eax

cmp eax, none
je ENDLABEL

call Multiplying
jmp INPUT

call DumpRegs

ENDLABEL :
mov edx, OFFSET sEnd
call WriteString
INVOKE ExitProcess, 0
main ENDP

; ------------------------------------------------------------------------------
Multiplying PROC
; Multiply multiplier and multiplicand using shl, shr operator
; Receives: left, right
; Returns: nothing
; ------------------------------------------------------------------------------
mov ecx, 32
clc
mov expon, 0
L1:
shr left, 1
jnc NEXT
mov ebx, right

push ecx
mov cl, expon

shl ebx, cl
add result, ebx
pop ecx

NEXT :
add expon, 1
loop L1

mov edx, OFFSET sProduce
call WriteString
mov eax, result
call WriteHex
call Crlf

ret
Multiplying ENDP

END main