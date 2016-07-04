; antidebug11.asm (APIs kernel32!OutputDebugStringA)
;
; This macro MUST return when a debugger has been or not detected while executing
; EAX > 0 debugger detected, 0 otherwise
;
DetectDebugger macro
	
	; This method invokes OutputDebugStringA
	; with a valid string. Under normal conditions, returns 1
	; under debugger, returns offset of string

	xor eax, eax
	invoke OutputDebugStringA, offset strCaption
	dec eax
	; Set variable
	mov dword ptr [intDetectDebug], eax

endm
