; antidebug8.asm (API kernel32!SetUnhandledExceptionFilter)
;
; This procedure MUST return if a debugger has been or not detected while executing
; EAX > 0 debugger detected, 0 otherwise
;
DetectDebugger macro
	
	; We invoke SetUnhandledExceptionFilter
	; You must now HOW WORKS exception handler by the OS
	; (indeed, it uses ntdll!NtQueryInformationProcess for detection)
	
	push notDebugged
	call SetUnhandledExceptionFilter	; Set exception handler function 
	xor eax, eax
	mov eax, dword ptr ds:[eax] ; Provoke exception
	; This program ENDS DIRECTLY if it's being debugged
	; (with exception)

notDebugged:
	; Come here if not debugged...
	xor eax, eax
	mov dword ptr ds:[intDetectDebug], eax
endm

