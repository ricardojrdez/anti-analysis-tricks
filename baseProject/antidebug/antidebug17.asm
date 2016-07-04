; antidebug17.asm (API RtlSetProcessIsCritical)
;
; It provokes an error when executing under debug
; (see the theory! :D)
;

; It is needed to define
;
; .data
; LibName db "ntdll", 0
; ProcName db "RtlSetProcessIsCritical", 0
;
; and as proc
;
;FinalExHandler PROC C, pExPointers:PTR EXCEPTION_POINTERS
;		; do nothing
;		ret
;FinalExHandler ENDP


DetectDebugger macro
	
	invoke SetUnhandledExceptionFilter, FinalExHandler
	invoke LoadLibrary, addr LibName
	invoke GetProcAddress, eax, addr ProcName
	push 0
	push 0
	push 1
	call eax
	call ExitProcess
	
exitWithError: 
	; Exit with error, do nothing :S
	
endm

