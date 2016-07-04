; antitracing1.asm (Ice breakpoint)
;
; This macro MUST return is a debugger has been or not detected while executing
; EAX > 0 debugger detected, 0 otherwise
;
DetectDebugger macro
	
	; We use the Intel's instruction 0xF1
	; This instruction generates SINGLE_STEP execution
	; Under a debugger, it thinks it's a normal exception,
	; and associated handler is not executed...
	ASSUME fs:nothing
	
	push offset handler
	push dword ptr fs:[0]
	mov fs:[0], esp
	
	; Opcode 0xF1h
	db 0F1h
	; If these executions are executed, we're being traced!
	xor eax, eax
	inc eax
	jmp endMacro
handler:
	xor eax, eax
endMacro:
	; Set variable
	mov dword ptr [intDetectDebug], eax
endm

