;	161663_3.asm

INCLUDE irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess Proto, dwExitCode:DWORD

.data
CaseTable	BYTE	'1';	lookup value
DWORD	Process_1;	address of procedure
EntrySize = ($ - CaseTable)
BYTE	'2'
DWORD	Process_2
BYTE	'3'
DWORD	Process_3
BYTE	'4'
DWORD	Process_4
NumberOfEntries = ($ - CaseTable) / EntrySize

hexInput BYTE 33 DUP(0)

prompt1 BYTE "Choose Calculation Mode : ", 0
prompt2 BYTE "Do you want to change the mode(Y/N)? : ", 0
i1 BYTE "1. x AND y", 0
i2 BYTE "2. X OR y", 0
i3 BYTE "3. NOT x", 0
i4 BYTE "4. x XOR y", 0
i5 BYTE "5. Exit program", 0

enterx BYTE "Enter x : ", 0
entery BYTE "Enter y : ", 0
r1   BYTE "Result of x AND y : ", 0
r2   BYTE "Result of x OR y : ", 0
r3   BYTE "Result of NOT x : ", 0
r4   BYTE "Result of x XOR y : ", 0
bye	 BYTE "bye!", 0

.code
main PROC

L:
call PrintInst
NEW:
mov edx, OFFSET prompt1
call WriteString
call ReadInt

cmp eax, 5
je QUIT
cmp eax, 6
jae NEW
cmp eax, 0
jle NEW

add eax, '0'
CONT:
mov ebx, OFFSET CaseTable
mov ecx, NumberOfEntries
L1:
cmp al, [ebx]
jne L2
call NEAR PTR [ebx + 1]
jmp L3

L2:
add ebx, EntrySize
loop L1

L3 :
call Crlf
push eax
mov edx, OFFSET prompt2
call WriteString
call ReadChar
call WriteChar
call Crlf
call Crlf
cmp al, 'Y'
je YES
 cmp al, 'y'
 je YES
cmp al, 'N'
je NO
 cmp al, 'n'
 je NO

YES:
pop eax
jmp NEW
NO:
pop eax
jmp CONT

QUIT:
mov edx, OFFSET bye
call WriteString
INVOKE ExitProcess, 0
main ENDP

Process_1 PROC USES eax ebx
mov edx, OFFSET enterx
call InputHex
mov ebx, eax
mov edx, OFFSET entery
call InputHex
and eax, ebx
mov edx, OFFSET r1
call WriteString
call WriteHex
call Crlf
ret
Process_1 ENDP

Process_2 PROC USES eax ebx
mov edx, OFFSET enterx
call InputHex
mov ebx, eax
mov edx, OFFSET entery
call InputHex
or eax, ebx
mov edx, OFFSET r2
call WriteString
call WriteHex
call Crlf
ret
Process_2 ENDP

Process_3 PROC USES eax ebx
mov edx, OFFSET enterx
call InputHex
not eax
mov edx, OFFSET r3
call WriteString
call WriteHex
call Crlf
ret
Process_3 ENDP

Process_4 PROC USES eax ebx
mov edx, OFFSET enterx
call InputHex
mov ebx, eax
mov edx, OFFSET entery
call InputHex
xor eax, ebx
mov edx, OFFSET r4
call WriteString
call WriteHex
call Crlf
ret
Process_4 ENDP

InputHex PROC USES ebx
Read:
call WriteString
push edx
mov edx, OFFSET hexInput
mov ecx, 32
call ReadString
pop edx

mov ecx, eax
mov esi, OFFSET hexInput
L1:
mov bl, [esi]
NUM:
cmp bl, 30h
jb Read
cmp bl, 39h
jbe OK
UPPER:
cmp bl, 41h
jb Read
cmp bl, 46h
jbe OK
LOWER:
cmp bl, 61h
jb Read
cmp bl, 66h
jbe OK
ja Read
OK:
inc esi
loop L1

mov ecx, eax
mov eax, 0
mov esi, OFFSET hexInput

L2:
mov ebx, 0
mov bl, [esi]
cmp bl, 39h
jbe NUMCAL
cmp bl, 46h
jbe UPCAL
cmp bl, 66h
jbe LOWCAL

NUMCAL:
sub ebx, 30h
jmp CAL
UPCAL:
sub ebx, 41h
add ebx, 10
jmp CAL
LOWCAL:
sub ebx, 61h
add ebx, 10
CAL:
push ecx
sub ecx, 1
shl ecx, 2
shl ebx, cl
pop ecx
add eax, ebx
inc esi
loop L2

ret
InputHex ENDP

PrintInst PROC
mov edx, OFFSET i1
call WriteString
call Crlf
mov edx, OFFSET i2
call WriteString
call Crlf
mov edx, OFFSET i3
call WriteString
call Crlf
mov edx, OFFSET i4
call WriteString
call Crlf
mov edx, OFFSET i5
call WriteString
call Crlf
call Crlf

ret
PrintInst ENDP

END main