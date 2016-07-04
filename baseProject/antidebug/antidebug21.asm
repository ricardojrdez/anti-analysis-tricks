; antidebug21.asm (OllyDBG memory trick)
;
; This macro MUST return when a debugger has been or not detected while executing
; EAX > 0 debugger detected, 0 otherwise
;

DetectDebugger macro
	;
	; Bad exception interpretation: under OllyDBG, not memory exception -> it's treated as
	; memory exception!
	; 
	; XXX: You need to add this to 'baseProject.inc'
	; memoryAddr	dd 0
	; oldProt		dw 0
	;
	ASSUME fs:nothing
	
initCode:
	;SEH handler
	push offset notDebug
	push dword ptr fs:[0]
	mov fs:[0], esp

	; Create memory space
	invoke VirtualAlloc, NULL, 010h, MEM_COMMIT, PAGE_READWRITE
	; Fill it
	mov dword ptr [memoryAddr], eax
	invoke RtlFillMemory, dword ptr [memoryAddr], 1, 0C3h
	; And protect it!
	invoke VirtualProtect, dword ptr [memoryAddr], 1, PAGE_EXECUTE_READ or PAGE_GUARD, addr oldProt
	
	; Set debugger detected...
	mov dword ptr [intDetectDebug], 1
	; Call memory protected zone
	call dword ptr [memoryAddr]
	jmp endMacro

notDebug:
	; Here falls if not OllyDBG present...
	xor eax, eax
	mov [intDetectDebug], eax
endMacro:

endm
	