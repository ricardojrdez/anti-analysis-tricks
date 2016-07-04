; antidebug18.asm (INT3)
;
; This macro MUST return when a debugger has been or not detected while executing
; EAX > 0 debugger detected, 0 otherwise
;
DetectDebugger macro
	ASSUME fs:nothing
	
	push offset notDebug
	push dword ptr fs:[0]
	mov fs:[0], esp
	
	; Generate debug event
	db 0CCh
beingDebugged:
	xor eax, eax
	inc eax
	jmp endMacro
notDebug:
	xor eax, eax
endMacro:
	; Set variable
	mov dword ptr [intDetectDebug], eax

endm
