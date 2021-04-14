;	Exponential Power(161663_3.asm)

INCLUDE irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess Proto, dwExitCode:DWORD

.data
INCLUDE hw3.inc
count DWORD ?

.code
main PROC

mov ecx, Y					; 
dec ecx						; set outer loop counter
mov eax, X					;

L1:							; outer loop for calculate X^Y
	mov count, ecx			; save outer loop counter
	mov ecx, X				; set inner loop counter
	mov edx, 0				;
	
	L2:						; inner loop for calculate X^Y
		add edx, eax		; add X^(i-1) for X times -> X^i
		loop L2				; repeat the inner loop
	
	mov eax, edx			;
	mov ecx, count			; restore outer loop counter
	loop L1					; repeat the outer loop

mov ecx, X
dec ecx
mov ebx, Y

L3:
	mov count, ecx
	mov ecx, Y
	mov edx, 0

	L4:
		add edx, ebx
		loop L4
	
	mov ebx, edx
	mov ecx, count
loop L3

call DumpRegs

INVOKE ExitProcess, 0
main ENDP
END main