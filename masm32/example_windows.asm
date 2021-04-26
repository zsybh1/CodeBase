;窗口程序GUI的示例
.386
.model flat, stdcall
option casemap:none
includelib msvcrt.lib

MessageBoxA proto :dword, :dword, :dword, :dword
MessageBox equ MessageBoxA
NULL equ 0
MB_OK equ 0
.stack 4096

.data
	szTitle byte 'Hi!', 0
	szMsg byte 'Hello World!', 0

.code
start:
	invoke MessageBox, NULL, offset szMsg,
		   offset szTitle, MB_OK
	ret
end start