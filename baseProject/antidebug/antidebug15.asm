; antidebug15.asm (API kernel32!OpenProcess)
;
; This macro MUST set intDetectDebug if debug has been or not detected 
; = 0 not detected, != 0 if detected
;
DetectDebugger macro
	;
	; We're gonna try to open csrss.exe with PROCESS_ALL_ACCESS
	; We cannot access in normal conditions
	; *but* it's successful under the presence of a debugger...
	; It uses SeDebugPrivilege for detecting debugger, then
	; it may happen that the debugger is not running on a high privilege
	; level and obtain a 'false negative'
	;
	; Get ID of csrss running process (Windows process)
	invoke CsrGetProcessId
	; Try to open it
	invoke OpenProcess, PROCESS_ALL_ACCESS, FALSE, eax
	; Test error, if any
	or eax, eax
	je cleanExit
	inc eax
	jmp endMacro
cleanExit:
	xor eax, eax
endMacro: 
	; Set variable
	mov dword ptr [intDetectDebug], eax
endm

