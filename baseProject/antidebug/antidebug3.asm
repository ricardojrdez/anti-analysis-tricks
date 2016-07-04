; antidebug3.asm (PEB NtGlobalFlags)
;
; This macro MUST set intDetectDebug if debug has been or not detected 
; = 0 detected, != 0 if detected
;
DetectDebugger macro
	ASSUME fS:nothing

	; Instead of reading directly @PEB + 2 flag,
	; we complicate it by checking NtGlobalFlags, set when process is created 
	mov eax, dword ptr fs:[30h] ; read PEB
	mov eax, [eax + 68h] ; get flags and leaves it in EAX
	; If process is debugged, then it has some flags:
	; FLG_HEAP_ENABLE_TAIL_CHECK, FLG_HEAP_ENABLE_FREE_CHECK and
	; FLG_HEAP_VALIDATE_PARAMETERS
	and eax, 70h
	; Set variable
	mov dword ptr [intDetectDebug], eax

endm
