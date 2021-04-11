;	Fibonacci Numbers(161663_2.asm)

INCLUDE irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess Proto, dwExitCode:DWORD

.data
INCLUDE hw2.inc

.code
main PROC
	mov EBX, 1					; EBX : fib(i - 2), fib(1) = 1
	mov EDX, 1					; EDX : fib(i - 1), fib(2) = 1
	mov ECX, fib				;			
	sub ECX, 2					; loop counter (fib - 2)

	L1 :
		mov EAX, EBX			; EAX : fib(i) <- fib(i - 2)
		add EAX, EDX			; EAX : fib(i) <- fib(i) + fib(i - 1) = fib(i - 2) + fib(i - 1)
		mov EBX, EDX			; fib(i - 2) <- fib(i - 1)  renew fib(i - 2) for next fib(i)
		mov EDX, EAX			; fib(i - 1) <- fib(i)		renew fib(i - 1) for next fib(i)
	loop L1

	call DumpRegs

	INVOKE ExitProcess, 0
main ENDP
END main