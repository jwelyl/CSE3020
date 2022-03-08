;	161663_1.asm

INCLUDE irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess Proto, dwExitCode:DWORD

.data
INCLUDE hw3.inc
comma  BYTE ", ", 0
before BYTE "Before sort : ", 0
after  BYTE "After sort : ", 0
bye	   BYTE "Bye!", 0
.code
main PROC

mov ecx, LenData
mov edx, OFFSET before
mov esi, OFFSET ArrData
call PrintArray

call BubbleSort

mov edx, OFFSET after
call PrintArray
mov edx, OFFSET bye
call WriteString

INVOKE ExitProcess, 0
main ENDP

BubbleSort PROC USES eax ecx esi
cmp ecx, 2
jbe SORT_END
sub ecx, 2

; mov ebx, 0
L1:
mov ebx, 0
pop esi
push esi
push ecx
L2 :
cmp ebx, 0
je  FIRST
jne SECOND

FIRST :
mov ebx, 1
mov eax, [esi]
mov edx, [esi + 8]
mov ax, 0
mov dx, 0
cmp eax, edx
ja CHANGE_ODD
jb L3
mov eax, [esi]
mov edx, [esi + 8]
cmp ax, dx
jb CHANGE_ODD
jmp L3
CHANGE_ODD :
mov eax, [esi]
xchg eax, [esi + 8]
mov[esi], eax
jmp L3

SECOND :
mov ebx, 0
mov eax, [esi]
mov edx, [esi + 8]
mov ax, 0
mov dx, 0
cmp eax, edx
jb CHANGE_EVEN
ja L3
mov eax, [esi]
mov edx, [esi + 8]
cmp ax, dx
ja CHANGE_EVEN
jmp L3
CHANGE_EVEN :
mov eax, [esi]
xchg eax, [esi + 8]
mov[esi], eax
jmp L3

L3 :
add esi, 4
loop L2
pop ecx
loop L1

SORT_END :
ret
BubbleSort ENDP

PrintArray PROC USES eax ecx edx esi
call WriteString
L1:
mov eax, [esi]
call WriteHex
cmp ecx, 1
jz L2
mov edx, OFFSET comma
call WriteString
L2:
add esi, 4
loop L1
call crlf
ret
PrintArray ENDP

END main