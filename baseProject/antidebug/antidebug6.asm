; antidebug6.asm (API ntdll!NtQueryInformationProcess)
;
; This macro MUST set intDetectDebug if debug has been or not detected 
; = 0 detected, != 0 if detected
;
DetectDebugger macro
	
	; We invoke NtQueryInformationProcess
	; it's a wrapper of ZwQueryInformationProcess
	; one of the arguments it needs, ProcessInformationClass,
	; can be set to 0x07 to check the existence of a debbuger
	; It returns -1 (ProcessInformation var) while being debugged 

	invoke NtQueryInformationProcess, -1, 7, offset intDetectDebug, 4, 0
	test eax, eax
	jne exitWithError
	
	
exitWithError: 
	; Exit with error, do nothing :S
	
endm

