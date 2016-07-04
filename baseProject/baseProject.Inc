
include windows.inc
include kernel32.inc
include user32.inc
include Comctl32.inc
include shell32.inc
include ntdll.inc

includelib ntdll.lib
includelib kernel32.lib
includelib user32.lib
includelib Comctl32.lib
includelib shell32.lib

DlgProc			PROTO	:HWND,:UINT,:WPARAM,:LPARAM

.const

IDD_DIALOG1			equ 101
IDC_BTN1			equ 1001 

.data
intDetectDebug		dd	0 ; Variable used to detect debugger
strDebugDetect		db "DEBUGGER DETECTED.... ERASING HARD DRIVE...", 0
strNoDebugDetect	db "You are clean, come on in!", 0
strCaption			db "Detect debugger", 0


;#########################################################################

.data?

hInstance			dd ?

;#########################################################################
