; antidebug24.asm (IsDebuggerPresent setter/getter)
;
; This macro MUST return when a debugger has been or not detected while executing
; EAX > 0 debugger detected, 0 otherwise
;

DetectDebugger macro
	;
	; This trick is very simple: we gonna avoid the easiest hide debugger plugins
	; We set the flag PEB.BeingDebugged to a specific value, and then
	; we retrieve the value of kernel32!IsDebuggerPresent. When it matchs, no debug.
	; Otherwise, really piss me off...
	;
	ASSUME fs:nothing
	
	mov eax, fs:[30h]			; Get PEB
	mov byte ptr ds:[eax + 2], 28h ; Fake flag
	
	; Now invoke to IsDebuggerPresent
	invoke IsDebuggerPresent
	cmp eax, 028h
	je notDebug
	xor eax, eax
	inc eax
	jmp endMacro
notDebug:
	xor eax, eax
endMacro:
	mov [intDetectDebug], eax

endm
	