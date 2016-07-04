; antidebug9.asm (API ntdll!NtSetInformationThread)
;
; This procedure MUST return if a debugger has been or not detected while executing
; EAX > 0 debugger detected, 0 otherwise
;
DetectDebugger macro
	
	; We invoke SetInformationThread
	; it needs a paramenter, ThreadInformationClass
	; if you sets this value at 0x11, then the thread is deattached
	; from debugger
	invoke NtSetInformationThread, -2, 11h, 0, 0
	; -2 -> this thread
	; 11h -> ThreadHideFromDebugger constant
	xor eax, eax
	; Check debugger now, if you are in it :D!
	; Set variable
	mov dword ptr [intDetectDebug], eax

endm

