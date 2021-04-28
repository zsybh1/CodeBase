;汇编中函数（子程序）的使用方式
;在masm中可以简化，见function_new.asm

;传统子程序定义方式
    funcName proc   ;parameters可以没有
        ...
        ret
    funcName endp

;调用子程序
    push eax
    push ebx    ;保存现场(如果有必要)
    ...
    call funcName   ;调用子程序
    ...
    pop ebx
    pop eax     ;恢复现场，注意与保存时的顺序相反

;传参方式
    ;1.使用寄存器传参
    ;2.使用内存变量传参
    ;3.通过堆栈传参(推荐)
    
    ;两种主要的堆栈传参规则
    ;cdecl方式，C函数默认方式
    ;参数从右往左入栈，函数内使用[ebp+8],[ebp+12]等访问第一第二个参数
    ;主程序中把参数弹出

    ;stdcall方式，winapi默认方式
    ;参数同cdecl
    ;子程序ret时自动平衡参数

    ;假设参数有两个，子程序中
    push ebp
    mov ebp, esp
    ...
    mov eax, [ebp+8]    ;取出第一个参数
    add eax, [ebp+12]   ;取出第二个参数
    ...
    pop ebp
    ret     ;cdecl方式中
    ret 8   ;stdcall方式中
    ;主程序中
    push 10     ;放入第二个参数
    push 20     ;放入第一个参数
    call subproc
    add esp, 8  ;cdecl方式中
                ;stdcall方式中主程序无需再平衡堆栈
    
;局部变量
    push ebp
    mov ebp, esp
    sub esp, x  ;在栈中预留出局部变量的空间
    ...
    add esp, x  ;弹出局部变量
    pop ebp
    ret