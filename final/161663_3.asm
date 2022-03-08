INCLUDE Irvine32.inc

.data
query BYTE "Is this string palindrome? : ", 0
yes BYTE "It's a palindrome!", 0
no BYTE "It's NOT a palindrome!", 0
buffer BYTE 21 DUP(0)
.code
main PROC
mov edx, OFFSET query
call WriteString
mov ecx, 21
mov edx, OFFSET buffer
call ReadString

cmp eax, 1
je YESP

mov esi, 0
mov edi, eax
dec edi
shr eax, 1
mov ecx, eax

L1:
movzx eax, buffer[esi]
movzx ebx, buffer[edi]
cmp eax, ebx
jne NOPE
loop L1

YESP:
mov edx, OFFSET yes
call WriteString
jmp QUIT
NOPE:
mov edx, OFFSET no
call WriteString
QUIT:
exit
main ENDP

END main