; antidebug20.asm (Special OllyDBG disassembly trick)
;
; This macro MUST return when a debugger has been or not detected while executing
; EAX > 0 debugger detected, 0 otherwise
;
DetectDebugger macro
	ASSUME fs:nothing
	; 
	; This technique of antidebugging it is very strong
	; It uses a bug of OllyDBG during floating-point instructions
	; OllyDBG has not mask on invalid floating-point operation errors, and hence
	; when it tries to analyse/disassamble this codes, it crashes!
	; Try anyway to reach the executable, even attaching it!
	
	; Set SEH
	push offset handler
	push dword ptr fs:[0]
	mov fs:[0],esp
	
	; Generate exception
	fld tbyte ptr [badNumbersForOlly]
	nop
badNumbersForOlly:
	dq -1
	dw 0C03Dh ; This value can be sustituted by its corresponding possitive one
	; dw 0403Dh
	

handler:
	; Do nothing in the handler
	nop

endMacro:
	; Set variable
	mov dword ptr [intDetectDebug], eax
endm

