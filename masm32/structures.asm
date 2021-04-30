;一些常用的程序结构

;联合union
    unionBuf union
        fileBuffer byte 4096 dup(?)
        outputBudder byte 2000 dup(?)
    unionBuf ends

    myBuffer unionBuf <>

    ;.code
    lea esi, myBuffer.fileBuffer
    lea esi, myBuffer.outputBudder

;结构体struct
    name struct
        item1 word ?
        item2 dword ?
    name ends

    name struct1 <, 1>  ;部分初始化

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

;典型的for循环反汇编结构
;for (int i = 0; i < 4; ++i) {
005B192A  mov         dword ptr [ebp-30h],0  
005B1931  jmp         main+0ACh (05B193Ch)  ;截止这里是初始化
005B1933  mov         eax,dword ptr [ebp-30h]  ;这里正式开始循环
005B1936  add         eax,1  
005B1939  mov         dword ptr [ebp-30h],eax  ;截止这里是迭代
005B193C  cmp         dword ptr [ebp-30h],4  
005B1940  jge         main+18Dh (05B1A1Dh)  ;截止这里是结束条件
...
005B1A18  jmp         main+0A3h (05B1933h)  ;循环