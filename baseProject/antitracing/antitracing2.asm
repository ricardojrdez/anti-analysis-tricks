; antitracing2.asm (POPF and trap flag)
;
; This macro MUST return is a debugger has been or not detected while executing
; EAX > 0 debugger detected, 0 otherwise
;
DetectDebugger macro

	; Trap flag controls the tracing of the program
	; If this flag is set, then it's raised SINGLE_STEP exception
	; We can set directly flags with PUSHF/POPF instructions
	ASSUME fs:nothing
	
	push offset handler
	push dword ptr fs:[0]
	mov fs:[0], esp
	
	pushf
	mov dword ptr [esp], 0100h
	popf
	xor eax, eax
	inc eax
	jmp endMacro
	
handler:
	xor eax, eax
endMacro:
	; Set variable
	mov dword ptr [intDetectDebug], eax
endm

