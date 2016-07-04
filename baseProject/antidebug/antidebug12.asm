; antidebug12.asm (API ntdll!NtYieldExecution)
;
; This macro MUST return when a debugger has been or not detected while executing
; EAX > 0 debugger detected, 0 otherwise
;
DetectDebugger macro
	; 
	; This API,  ntdll!NtYieldExecution, is used to leave the current thread
	; quantum to other scheduled thread ready to execute
	; Returns an error if no threads are scheduled to execute
	; When being debugged, single-step causes debug event, then always
	; exists a thread to resume execution: the own debugger
	; 
	; NOTE THAT it could be used as well to infer the presence of a thread with
	; high priority

	call NtYieldExecution
	cmp eax, 0
	je debugger_detected
	xor eax, eax
	jmp endMacro
debugger_detected:
	inc eax
endMacro:
	mov dword ptr [intDetectDebug], eax
endm
