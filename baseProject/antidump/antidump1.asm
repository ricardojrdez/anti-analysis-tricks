; antidump1.asm (PEB.SizeOfImage trick)
; 
; Fakes PEB.SizeOfImage to prevent process of being dumped
; May works or not, depends on the tool used for dumping...
; Tested to work in LordPE, unfortunately I can't say the same
; in the case of OllyPE dump plugin...
;
DetectDebugger macro
	ASSUME fs:nothing
	
	; Btw, addresses change in case of being in Win9x... 
	;  but who matters this fact?
	mov eax, fs:[30h]		; Get PEB
	mov eax, [eax + 0Ch]	; PEB.LDR_DATA
	mov eax, [eax + 0Ch]	; InOrderModuleList
	
	; And now, modify SizeOfImage
	mov dword ptr [eax], 0x0CACAFEA
 endm
