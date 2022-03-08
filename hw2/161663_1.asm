;	161663_1.asm

INCLUDE irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess Proto, dwExitCode:DWORD

.data
var1 BYTE "453314645", 0
septSize = ($ - var1) - 1
mult DWORD 7
temp DWORD 0

.code
main PROC
mov ecx, septSize
mov esi, septSize - 1
mov eax, 1
L1:
push eax
movzx ebx, var1[esi]
push ebx
mul mult
dec esi
loop L1

mov ecx, septSize
L2 : pop eax
	pop ebx
	and eax, 0FFFFFFCFh
	mul ebx
	add temp, eax
	loop L2

	mov eax, temp
	call DumpRegs

	INVOKE ExitProcess, 0
	main ENDP
	END main