; antidebug1.asm (API kernel32!IsDebuggerPresent)
; 
; This macro MUST set intDetectDebug if debug has been or not detected 
; = 0 detected, != 0 if detected
;
DetectDebugger macro
	
	; Invoke kernel32!IsDebuggerPresent
	; Returns (EAX) a 1 if the process is being debugged, 0 otherwise
	; (indeed, it reads the 2nd byte in the PEB (Process Environment Block) structure)
	invoke IsDebuggerPresent
	; Set variable
	mov dword ptr [intDetectDebug], eax

 endm
