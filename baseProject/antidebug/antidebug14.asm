; antidebug14.asm (API kernel32!LoadLibraryA)
;
; This macro MUST return is a debugger has been or not detected while executing
; EAX > 0 debugger detected, 0 otherwise
;
DetectDebugger macro
	
	; This method uses the LoadLibraryA API to detect debugger
	; Indeed, it's a trick: file handlers remain when a program is being debugged,
	; even if the file has been freed. Therefore, if we try to open the same file
	; *in exclusive access*, it cannot be opened!
	
	mov esi,  offset file
	push esi
	call LoadLibraryA
	push eax
	call FreeLibrary
	
	invoke CreateFile, esi, GENERIC_WRITE, 0, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
	inc eax
	je debugDetected
	xor eax, eax
	jmp endMacro

file:
	db "urlmon.dll", 0 ; System DLL to load/release
	
debugDetected:
	inc eax
endMacro:
	; Set variable
	mov dword ptr [intDetectDebug], eax
endm

