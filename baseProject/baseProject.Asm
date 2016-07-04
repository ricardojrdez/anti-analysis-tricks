;
; [Name]:   baseProject.asm
; [Author]: R.J. Rodríguez (@RicardoJRdez)
; [Descr.]: Skeleton code used to test each anti-analysis trick
;

.386
.model flat, stdcall  ;32 bit memory model
option casemap :none  ;case sensitive

include baseProject.inc

;%%%%%%%%%%%%
; Anti-debug
;%%%%%%%%%%%%
;
; Memory-based
;
include antidebug/antidebug1.asm
;include antidebug/antidebug2.asm
;include antidebug/antidebug3.asm
;include antidebug/antidebug4.asm
;include antidebug/antidebug5.asm
;
; OS-based
;
;include antidebug/antidebug6.asm
;include antidebug/antidebug7.asm
;include antidebug/antidebug8.asm
;include antidebug/antidebug9.asm
;include antidebug/antidebug10.asm
;include antidebug/antidebug11.asm
;include antidebug/antidebug12.asm
;include antidebug/antidebug13.asm
;include antidebug/antidebug14.asm
;include antidebug/antidebug15.asm
;include antidebug/antidebug16.asm
;include antidebug/antidebug17.asm
;include antidebug/antidebug18.asm
;include antidebug/antidebug20.asm
;include antidebug/antidebug21.asm
;include antidebug/antidebug22.asm
;include antidebug/antidebug23.asm

;%%%%%%%%%%%%
; Anti-tracing
;%%%%%%%%%%%%
;include antitracing/antitracing1.asm
;include antitracing/antitracing2.asm
;include antitracing/antitracing3.asm

;%%%%%%%%%%%%
; Anti-dump
;%%%%%%%%%%%%
;include antidump/antidump1.asm
;include antidump/antidump2.asm

.code

start:
	DetectDebugger
	invoke GetModuleHandle,NULL
	mov		hInstance,eax

    invoke InitCommonControls
	invoke DialogBoxParam,hInstance,IDD_DIALOG1,NULL,addr DlgProc,NULL
	invoke ExitProcess,0

;########################################################################

DlgProc proc hWin:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM

	mov		eax,uMsg
	.if eax==WM_INITDIALOG

	.elseif eax==WM_COMMAND
		mov		edx,wParam
		movzx	eax,dx
		shr		edx,16
		.if edx==BN_CLICKED
			.if eax==IDC_BTN1
				; Test debugger
				.if intDetectDebug != 0
					invoke MessageBox, 0, addr strDebugDetect, addr strCaption, MB_ICONERROR
				.else
					invoke MessageBox, 0, addr strNoDebugDetect, addr strCaption, MB_OK
				.endif
			.endif
		.endif

	.elseif eax==WM_CLOSE
		invoke EndDialog,hWin,0
	.else
		mov		eax,FALSE
		ret
	.endif
	mov		eax,TRUE
	ret

DlgProc endp

end start
