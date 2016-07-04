; antidebug16.asm (API ntdll!NtQueryInformationProcess)
;
; This macro MUST set intDetectDebug if debug has been or not detected 
; = 0 detected, != 0 if detected
;
DetectDebugger macro
	
	; We invoke NtQueryInformationProcess
	; it's a wrapper of ZwQueryInformationProcess
	; one of the arguments it needs, ProcessInformationClass,
	; can be set to 0x1e to check the existence of a debbuger
	; via ProcessDebugObjectHandle
	; Since WinXP, when a program is debugged, a debug object is created
	; for that debugging session
	; It returns -1 (ProcessInformation var) while being debugged 

	invoke NtQueryInformationProcess, -1, 01eh, offset intDetectDebug, 4, 0
	test eax, eax
	jne exitWithError
	
	
exitWithError: 
	; Exit with error, do nothing :S
	
endm

