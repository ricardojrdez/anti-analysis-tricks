; antidebug10.asm (APIs kernel32!CloseHandle, ntdll!NtClose)
;
; This macro MUST return when a debugger has been or not detected while executing
; EAX > 0 debugger detected, 0 otherwise
;
DetectDebugger macro

	; Both APIs can be used to detect debugger
	; If we call these APIs with an invalid handler, it generates
	; STATUS_INVALID_HANDLE (0xC0..8) exception	
	
		
	; Invoke CloseHandle with bad handle, provoke exception
	invoke CloseHandle, 1234h
	; If keep executing here, then it's not being debugged...
	xor eax, eax
	; Set variable
	mov dword ptr [intDetectDebug], eax

endm
