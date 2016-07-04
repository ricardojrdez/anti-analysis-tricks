; antidebug13.asm (API ntdll!DbgBreakPoint)
;
; This macro MUST return when a debugger has been or not detected while executing
; EAX > 0 debugger detected, 0 otherwise
;
DetectDebugger macro
	;
	; This method protects our executable of being attached while executing
	; Compile, execute it and tries to reach it in OllyDBG :)
	;
	; Function ntdll!DbgBreakPoint is called by the debugger to gain control on the attached process
	push offset label1
	call GetModuleHandleA
	push offset label2
	push eax
	call GetProcAddress
	; These instructions above collect @ntdll.DbgBreakPoint
	
	push eax
	push esp
	push 40h ;PAGE_EXECUTE_READWRITE 
	push 1
	push eax
	xchg ebx, eax
	call VirtualProtect
	jmp endMacro
label1:
	db "ntdll", 0
label2:
	db "DbgBreakPoint", 0
endMacro:
	nop
endm

