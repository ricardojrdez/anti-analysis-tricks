; antidebug23.asm (Fake debugger)
;
; This macro MUST return when a debugger has been or not detected while executing
; EAX > 0 debugger detected, 0 otherwise
;

DetectDebugger macro
	ASSUME fs:nothing
	
	; 
	; This code fakes PEB.BeingDebugged flag, and generates a 
	; INT 3 implicit instruction.
	; If not consumed, then we're being debugged

	jmp initCode
	
validHeap:
	dd 0, 0, 0, 40000000h
	
initCode:

	;SEH handler
	push offset notDebug
	push dword ptr fs:[0]
	mov fs:[0], esp

	mov eax, fs:[30h]		; Get PEB
	inc byte ptr [eax + 2] 	; Fake flag
	
	;push offset valid
	invoke HeapDestroy, addr validHeap
	xor eax, eax
	inc eax	
	jmp endMacro
notDebug:
	xor eax, eax
endMacro:
	mov [intDetectDebug], eax

endm
	