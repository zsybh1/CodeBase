;模式定义
;程序的第一部分
.386    ;表示使用80386CPU。该语言的CodeBase的所有部分都默认至少80386CPU
.model flat, stdcall    ;stdcall是winAPI使用的调用规则
option casemap:none     ;对大小写敏感

;引入库文件
includelib msvcrt.lib
includelib kernel32.inc

;声明函数
printf  proto C :ptr sbyte, :vararg     ;ptr sbtye即char*. C表示C调用规则
printf  proto C :dword, :vararg     ;32位环境下指针也可以定义成dword
MessageBoxA proto :dword, :dword, :dword, :dword    ;A表示接受ASCII字符串。这一句是stdcall调用规则

;equ伪指令，类似C中的#define
MessageBox equ MessageBoxA

;直接使用预定义的声明
;需要使用相对路径，而且不能跨盘符
include kernel32.inc

;人工指定堆栈大小，一般可以交给系统自动分配
.stack 4096

;数据部分
.data
    ;数据定义
    ;Identifier type definitions
    ;type可以为byte word dword fword qword tbyte sbyte sword sdword
    ;s开头表示signed
    num dword 100
    array dword 1, 2, 3, 4  ;这里是个伪数组，实际上array的值为1，要获得首地址需要 offset array

;未定义初始变量部分，可以合并到data部分
.data?
    buffer byte 65536 dup(?)    ;定义数组大小65536初值未定义
    index dword ?   ;定义一个未初始化的类型

;定义常量数据，可以合并到data部分
.const
    msg byte 'Hello world!%d', 0ah, 0  ;0ah,0即\n\0，汇编中字符串本身都是raw string

;代码部分，不能把要修改的变量放在这个部分
.code
;入口位置
start:
    ;函数调用。offset等同于取地址，准确来说，是取段偏移量
    invoke printf, offset szMsg, array+4
    invoke MessageBox, NULL, offset szMsg,  ;太长可以自由换行
           offset szTitle, MB_OK
    ret ;return 0
end start   ;程序结束
