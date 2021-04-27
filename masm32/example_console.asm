;控制台CUI的示例
.386
.model flat, stdcall
option casemap:none
includelib msvcrt.lib

printf proto C :ptr sbyte, :vararg
scanf proto C :ptr sbyte, :vararg

.data
	tmp dword ?, ?
	msg byte "Please enter two number:", 0ah, 0
	inputstring byte "%d %d", 0
	outputstring byte "The sum of two numbers is:%d", 0ah, 0
.code
start:
	invoke printf, offset msg
	invoke scanf, offset inputstring, offset tmp, offset tmp+4
	mov eax, tmp
	add eax, tmp+4
	invoke printf, offset outputstring, eax
	ret
end start

