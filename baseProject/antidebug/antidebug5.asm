; antidebug5.asm (Vista)
;
; This macro MUST set intDetectDebug if debug has been or not detected 
; = 0 detected, != 0 if detected
;
DetectDebugger macro
	ASSUME fS:nothing

	;
	; This trick only works in Windows Vista
	;
	call GetVersion
	cmp al, 06h ; is it Vista? (God, I hope not!)
	jne notVista
	
	push offset notFound
	push dword ptr fs:[0] ; Set Structured Exception Handler
	mov fs:[0], esp
	mov eax, fs:[18h] ; get TEB (main thread)
	add eax, 0BCFh
	mov ebx, [eax] ; get pointer to a unicode string
	test ebx, ebx
	je notFound
	sub ebx, eax ; unicode string follows the pointer
	sub ebx, 4   ; 
	jne notFound
	; If comes here, debugger detected
	xor eax, eax
	inc eax
	
notVista:
notFound:
	xor eax, eax
endProc:
	; Set variable
	mov dword ptr [intDetectDebug], eax

endm
