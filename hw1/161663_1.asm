;	Summing the Gaps between Array Values(161663_1.asm)

INCLUDE irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess Proto, dwExitCode:DWORD

.data
INCLUDE hw1.inc

.code
main PROC
mov ECX, LENGTHOF array1 - 1	;	loop counter
mov ESI, OFFSET array1;			;	indirect addressing	
mov EAX, 0						;	Sum of Gaps

L1 :
add ESI, TYPE array1			;	move to array1[i + 1]
add EAX, [ESI]					;	move array1[i + 1] to EAX
sub ESI, TYPE array1			;	move to array1[i]
sub EAX, [ESI]					;	subtract array1[i] from EAX
add ESI, TYPE array1			;	move to array1[i + 1] for next gap

loop L1

call DumpRegs

INVOKE ExitProcess, 0
main ENDP
END main