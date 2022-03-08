INCLUDE Irvine32.inc

.data
prompt BYTE "Input : ", 0
.code
main PROC
mov edx, OFFSET prompt
call WriteString
call ReadInt
mov ecx, eax
mov eax, 0
mov al, '*'
mov ebx, 0

L1:
inc ebx
push ecx
mov ecx, ebx
L2:
call WriteChar
loop L2
pop ecx
cmp ecx, 1
jbe quit
call Crlf
quit:
loop L1
exit
main ENDP
END main