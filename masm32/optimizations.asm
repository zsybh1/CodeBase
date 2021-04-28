;一些常用的优化

;寄存器清零
    ;mov eax, 0
    xor eax, eax

;加减
    ;ebx = eax - 30
    ;mov ebx, eax
    ;sub ebx, 30
    lea ebx, [eax-30]

;乘除
    ;eax = eax/16
    shr eax, 4
    ;eax = eax*8
    shl eax, 3
    ;eax = ebx*5
    lea eax, [ebx+ebx*4]

    ;除法转乘法，可能会有+1的误差
    mov eax, 125
    mov ecx, 0a3d70a4h
    mul esi
    ;edx中存放商
    ;原理: a / b ~= a * ((100000000h + b-1) / b) / 100000000h

;消除分支
    ;eax = min(eax, ebx)
    sub ebx, eax
    mov ecx, ebx
    sar ecx, 31
    and ebx, ecx
    add eax, ebx
    ;原理min(x, y) = x+(((y-x)>>31)&(y-x))

    ;eax = max(eax, ebx)
    mov ecx, eax
    sub ecx, ebx
    mov ebx, ecx
    sar ecx, 31
    and ebx, ecx
    sub eax, ebx
    ;原理max(x, y) = x-(((x-y)>>31)&(x-y))

;联合union
    unionBuf union
    fileBuffer byte 4096 dup(?)
    outputBudder byte 2000 dup(?)
    unionBuf union

    myBuffer unionBuf <>

    ;.code
    lea esi, myBuffer.fileBuffer
    lea esi, myBuffer.outputBudder