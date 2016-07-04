; antidebug2.asm (IsDebuggerPresent variant)
;
; This macro MUST set intDetectDebug if debug has been or not detected 
; = 0 detected, != 0 if detected
;
DetectDebugger macro
	ASSUME fS:nothing

	; Instead of invoking kernel32!IsDebuggerPresent directly, 
	; we read the PEB structure 
	mov eax, dword ptr fs:[30h] ; read PEB
	movzx eax, byte ptr ds:[eax + 2] ; get flag and leaves it in EAX
	; Set variable
	mov dword ptr [intDetectDebug], eax

endm
