; antidebug7.asm (API kernel32!CheckRemoteDebuggerPresent)
;
; This procedure MUST return if a debugger has been or not detected while executing
; EAX > 0 debugger detected, 0 otherwise
;
DetectDebugger macro
	
	; We invoke CheckRemoteDebuggerPresent
	; Needs two parameters: process handle & pointer to dword variable
	; Sets to 1 the variable if debugger detected
	; Internally calls to ntdll!NtQeryInformationProcess with 
	; ProcessInformationClass set to ProcessDebugPort (0x07)
	invoke CheckRemoteDebuggerPresent, -1, offset intDetectDebug
	

endm
