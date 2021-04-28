;masm中的函数（子程序）使用方式
;使用伪指令简化了子程序的使用，masm编译后的版本同function.asm

;函数定义
subproc proc C/stdcall a:dword, b:ptr dword ;ptr dword即指针
        local temp[3]:dword, temp2, temp3:dword ;定义局部变量伪指令
        ;temp是Ctype数组，使用temp[0],temp[4]等调用
        ...
        mov eax, addr temp2 ;ebx = &temp2, offset只能用来取全局变量和标号的地址
        mov ebx, a  ;子程序中可以使用ebx
        ...
        ret     ;无需平衡堆栈
subproc endp

;函数调用
    invoke subproc, 10, offset tmp      ;类似库函数调用