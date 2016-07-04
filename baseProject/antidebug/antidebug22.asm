; antidebug22.asm (DeleteFiber)
;
; This macro MUST return when a debugger has been or not detected while executing
; EAX > 0 debugger detected, 0 otherwise
;

DetectDebugger macro
	;
	; This technique uses a trick of API DeleteFiber
	; Indeed, it collects information on Heap flags
	; There exist different last errors, depending on the 
	; presence or not of a debugger 
	; 
	jmp initCode
strTmp:  
	dd 5 dup(0)

initCode:
	push offset strTmp
	call DeleteFiber
	invoke GetLastError
	cmp eax, 057h
	jne endMacro
notDebug:
	xor eax, eax
endMacro:
	mov [intDetectDebug], eax

endm
	