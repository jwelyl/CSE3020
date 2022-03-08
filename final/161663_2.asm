INCLUDE Irvine32.inc

.data
input BYTE "Type_A_String_To_Reverse : ", 0
output BYTE "Reversed_String : ", 0
bye BYTE "Bye!", 0
buffer BYTE 101 DUP(0)
.code
main PROC
L:
call ReadInput
cmp eax, 0
je QUIT

call ReverseString
call WriteOutput


jmp L
QUIT:
mov edx, OFFSET bye
call WriteString
exit
main ENDP

ReadInput PROC
mov edx, OFFSET input
mov ecx, 100
L1:
push edx
call WriteString
mov edx, OFFSET buffer
call ReadString
pop edx
cmp eax, 40
ja L1
ret
ReadInput ENDP

ReverseString PROC
mov ebx, eax
mov ecx, ebx
mov esi, 0
L1:
movzx eax, buffer[esi]
push eax
inc esi
loop L1

mov ecx, ebx
mov esi, 0
L2:
pop eax
mov buffer[esi], al
inc esi
loop L2

ret
ReverseString ENDP

WriteOutput PROC
mov edx, OFFSET output
call WriteString
mov edx, OFFSET buffer
call WriteString
call Crlf
ret
WriteOutput ENDP
END main