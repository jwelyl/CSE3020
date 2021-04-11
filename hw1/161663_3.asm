;	Exponential Power(161663_3.asm)

INCLUDE irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess Proto, dwExitCode:DWORD

.data
INCLUDE hw3.inc

.code
main PROC
	mov ecx, Y					;	loop counter
	mov eax, 1					;	store X^0 to eax	
	
	L1 :
		mul X					;	mult X to eax
	loop L1						;	repeat X times
	mov ebx, eax				;	store X^Y in ebx register

	mov ecx, X					;	loop counter
	mov eax, 1					;	store Y^0 to eax
	
	L2:
		mul Y					;	mult Y to eax
	loop L2						;	repeat Y times

	;	swap eax and ebx
	mov edx, eax
	mov eax, ebx
	mov ebx, edx

	call DumpRegs

	INVOKE ExitProcess, 0
main ENDP
END main