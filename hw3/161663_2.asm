;	161663_2.asm

INCLUDE irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess Proto, dwExitCode:DWORD

.data
target BYTE "AAEBDCFBBC", 0
freqTable DWORD 256 DUP(0)
num_is  BYTE " : ", 0
.code
main PROC

mov ecx, LENGTHOF target - 1
mov esi, OFFSET target
mov edi, OFFSET freqTable
call Get_frequencies

mov ecx, 256
mov esi, OFFSET freqTable
call PrintTable

INVOKE ExitProcess, 0
main ENDP

Get_frequencies PROC
push ecx
push esi
push edi

L1:
mov eax, 0
mov ebx, 0
mov al, [esi]
mov bl, [esi]
shl ebx, 2
pop edi
add edi, ebx

inc DWORD PTR[edi]
mov al, [edi]

inc esi
sub edi, ebx
push edi
loop L1

pop edi
pop esi
pop ecx
ret
Get_frequencies ENDP

PrintTable PROC
mov edi, esi
L1:
mov eax, esi
sub eax, edi
sar eax, 2 

NUM:
cmp eax, 30h
jb NEXT
cmp eax, 39h
ja UPPER
jbe PRINT

UPPER:
cmp eax, 41h
jb NEXT
cmp eax, 5Ah
ja LOWER
jbe PRINT

LOWER:
cmp eax, 61h
jb NEXT
cmp eax, 7Ah
ja NEXT

PRINT:
mov ebx, [esi]
cmp ebx, 0
je NEXT

call WriteChar
mov edx, OFFSET num_is
call WriteString
mov eax, ebx
call WriteDec
call Crlf
jmp NEXT

NEXT:
add esi, 4
loop L1
ret
PrintTable ENDP

END main