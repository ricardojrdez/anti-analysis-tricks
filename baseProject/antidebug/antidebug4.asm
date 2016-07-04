; antidebug4.asm (Heap flags)
;
; This macro MUST set intDetectDebug if debug has been or not detected 
; = 0 detected, != 0 if detected
;
DetectDebugger macro
	ASSUME fS:nothing

	; This is a bit more complex: NtGlobalFlags informs, among other things,
	; how the heap routines will behave.
	; Suppose you modify PEB field, *but* if the heap behaviour is different when
	; it is not being debugged, this becomes problematic for sure.
	; We're gonna check ForceFlags field in heap header (@10) to test debugger presence
	mov eax, dword ptr fs:[30h] ; read PEB
	mov eax, [eax + 18h] ; get process flags
	mov eax, [eax + 10h] ; get heap flags
	; Set variable
	mov dword ptr [intDetectDebug], eax

endm
