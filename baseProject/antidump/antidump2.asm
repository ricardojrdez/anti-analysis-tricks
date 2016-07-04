; antidump2.asm (Remove all PE header on execution time)
; 
; This code removes PE header from running process.
; Use carefully, 'cause some WinAPI or others may access to 
; PE information for normal behaviour...
;
DetectDebugger macro
	;
	; XXX: Please 
	;	1. Add this to 'baseProject.inc' 
	;		oldTimes	dw	0
	;	2. Change the calling to this macro INSIDE DlgProc
	;		Why? DialogParamA reads PE... 
	;		so you shouldn't erase before this call 
	;		(if you want a program which runs :), of course...)

	; Get base address
	invoke GetModuleHandle, NULL
	push eax
	; Change protection of memory zone (to be able to modify it!)
	invoke VirtualProtect, eax, 4096, PAGE_READWRITE, addr oldTimes
	; XXX: 4096 -> assuming x86 page size...
	pop eax
	; Delete header (fill with 0x00 byte!)
	invoke RtlFillMemory, eax, 4096, 0h
	
 endm
