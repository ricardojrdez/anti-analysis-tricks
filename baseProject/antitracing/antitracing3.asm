; antitracing3.asm (Stack Segment register)
;
; This macro MUST return is a debugger has been or not detected while executing
; EAX > 0 debugger detected, 0 otherwise
;
DetectDebugger macro

	; This is a trick by using the POPF instruction (last one trick used)
	; and instruction POP SS
	; When a debugger executes POP SS, the enxt instruction is executed 
	; implicitly
	
	push ss
	pop ss
	pushf
	pop eax			; Get flags
	and eax, 0100h	; Trap flag enabled?
	or eax, eax
	;jne endMacro 	; If not zero, debugger detected!
	;xor eax, eax
endMacro:
	; Set variable
	mov dword ptr [intDetectDebug], eax
endm

