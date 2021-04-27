;一些常用的程序结构

;查找数组内是否存在特定元素
mov eax, var
mov ecx, len
lea edi, array
repnz scasd     ;ZF==0即未找到时重复查找

;判断语句
    cmp exp1, exp2  
    jg lab      ;if exp1 > exp2
    ...         ;else
    jmp next
lab:
    ...         ;if...
next:
    ...