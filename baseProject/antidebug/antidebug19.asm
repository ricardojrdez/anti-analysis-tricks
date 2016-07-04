; antidebug19.asm (Debug registers DR[0,1,2,3,6,7])
;
; This macro MUST return when a debugger has been or not detected while executing
; EAX > 0 debugger detected, 0 otherwise
;
DetectDebugger macro
	ASSUME fs:nothing
	; 
	; This technique of antidebugging clears hardware breakpoints
	; which can exists in the program.
	; Indeed, there is an instruction to do it directly: mov drX, ...
	; *but* runs in ring0. Luckily, we can do a trick to execute this 
	; in ring3: first, we raise an exception, and in the handler
	; we change the context of the thread, by modifying directly 
	; the debug registers...
	
	; Set SEH
	push offset handler
	push dword ptr fs:[0]
	mov fs:[0],esp
	
	; Generate exception
	xor eax, eax
	mov dword ptr [eax], eax
	; Return here from SEH, and keeps executing...
	jmp endMacro
	

handler:
	mov ecx, [esp + 0Ch] ;skip div
	add dword ptr [ecx + 0B8h], 2 ;skip div
	; Clear DR registers, DR[0,1,2,3,6,7]
	xor eax, eax
	mov dword ptr [ecx + 04h], eax
	mov dword ptr [ecx + 08h], eax
	mov dword ptr [ecx + 0Ch], eax
	mov dword ptr [ecx + 10h], eax
	mov dword ptr [ecx + 14h], eax
	mov dword ptr [ecx + 18h], eax
	ret

endMacro:
	; Set variable
	mov dword ptr [intDetectDebug], eax
endm

