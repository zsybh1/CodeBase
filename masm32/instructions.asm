;一些基本的指令

;数据操作符/伪指令
    [var]   ;*var
    offset var  ;&var
    seg var ;取段基址
    var[ebx]    ;[var+ebx]  ;*(var+ebx)
    type ptr var    ;(type)var
    $   ;取汇编程序中当前位置的地址计数器的值
    + - * / mod and or xor  ;编译时计算
    EQ NE LT LE GT GE;等于/不等于/小于/小于等于/大于/大于等于
    ;编译时计算 结果为真则全部二进制位1，为假全部二进制位0
    n dup(params,...)   ;将括号里的内容复制n次，可以嵌套
    D B H Q/O   ;分别表示十进制、二进制、十六进制、八进制
    var type value  ;定义var为type类型，值为value。其中value可以有多个，类似数组，但var只是第一个的值
    var equ exp ;#define var exp
    var = imm ;#define var imm

;数据传送指令
    mov dst, src    ;dst = src
    ;当汇编程序同时不知道双方的长度时需要进行标注
    mov word ptr [var], 4   ;*var = 4

    movsx dst, src  ;dst = src
    ;带符号扩展，把带符号的低位数的src寄存器/存储器传送到高位数的dst寄存器
    movzx dst, src  ;dst = src
    ;带零扩展，把不带符号的低位数的src寄存器/存储器传送到高位数的dst寄存器

;堆栈操作指令
    push src
    pop src
    pushf   ;16位标志寄存器进栈
    popf
    pushfd
    popfd   ;32位标志寄存器出栈

;地址传送指令
    lea reg, src    ;reg = &src
    ;等价于mov reg, offset src，但指令长度更短
    ;src必须是存储器操作数，reg必须是寄存器

;交换指令
    XCHG OP1, OP2   ;swap(op1, op2)
    ;两操作数不能是立即数，其中之一必须是寄存器操作数

;类型转换指令
    CBW ;ax = al    ;ah:al = al
    ;Convert Byte to Word
    CWD ;dx:ax = ax
    CDQ ;edx:eax = eax
    CWDE    ;eax = ax
    ;Convert Word to Doubleword Extended

;整数加法指令
;影响算术运算标志
    add dst, src    ;dst += src
    adc dst, src    ;dst += src + CF
    inc dst         ;dst++ 该指令不影响CF标志
    XADD dst, src   ;dst, src = dst+src, dst  80486以上支持

;整数减法指令
;影响算术运算标志
    sub dst, src    ;dst -= src
    sbb dst, src    ;dst -= src + CF
    dec dst         ;dst-- 该指令不影响CF标志
    cmp dst, src    ;dst - src  只影响标志位不改变值
    neg dst         ;dst = -dst  求补

;整数乘法指令
;影响算术运算标志且难以确定
    mul src
    imul src
    ;ax = al * src
    ;dx:ax = ax * src
    ;edx:eax = eax * src
    ;前者用于无符号数，如果乘积高半部分为0则CF和OF置0，否则置1
    ;后者用于带符号数，如果乘积高半部分为低半部分的符号扩展则CF和OF置0，否则置1
    imul reg, src   ;reg *= src
    ;reg和src长度相同且为16位或32位
    imul reg, imm   ;reg *= imm
    ;reg为16位或32位寄存器，imm只能是8位立即数
    imul reg, src, imm  ;reg = src * imm
    ;上面3个指令如果乘积完全放入目标寄存器则CF和OF置0，否则置1

;整数除法指令
;影响算术运算标志且难以确定
    div src
    idiv src
    ;al = ax / src   ah = ax mod src
    ;ax = dx:ax / src   dx = dx:ax / src
    ;eax = edx:eax / src   edx = edx:eax / src

;逻辑运算指令
    not dst         ;dst = ~dst  不影响标志
    and dst, src    ;dst &= src
    test op1, op2   ;op1 & op2
    or dst, src     ;dst |= src
    xor dst, src    ;dst ^= src
    ;上面4个指令会将CF和OF清0，影响SF、ZF和PF，AF不确定

;移位指令
    ;CF为最后移出的位，影响ZF，SF，PF
    ;CNT=1时符号位变化OF置1，否则为0
    ;CNT>1时OF不确定
    ;CNT可以是CL寄存器给出也可以是8位立即数
    shl dst, cnt    ;dst <<= cnt    逻辑左移
    sal dst, cnt    ;dst <<= cnt    算术左移
    shr dst, cnt    ;dst >>= cnt    逻辑右移
    sar sdt, cnt    ;dst >>= cnt    算术右移

    ;CF为最后移进的位，不影响ZF，SF，PF
    ;CNT=1时符号位变化OF置1，否则为0
    ;CNT>1时OF不确定
    ;CNT可以是CL寄存器给出也可以是8位立即数
    rol dst, cnt    ;循环左移
    ror dst, cnt    ;循环右移
    rcl dst, cnt    ;带进位循环左移
    rcr dst, cnt    ;带进位循环右移


;转移指令操作符
    short lab   ;8位以内 短转移
    lab         ;16位或者32位 近转移
    near ptr lab;同上
    far ptr lab ;转移到不同段的标签 段间转移

;转移指令
    jmp dst     ;无条件转移

    jc label    ;CF==1 有进位转移
    jnc label   ;CF==0 无进位转移
    jo label    ;OF==1 溢出转移
    jno label   ;OF==0 无溢出转移
    jp/jpe label    ;PF==1 偶转移
    jnp/jpo label   ;PF==0 奇转移
    js label    ;SF==0 负数转移
    jns label   ;SF==1 非负数转移
    jz label    ;ZF==1 结果为0转移
    jnz label   ;ZF==0 结果不为0转移

    ;以下指令一般配合cmp指令使用
    je label    ;ZF==1 相等转移
    jne label   ;ZF==0 不相等转移
    ;下面四句用于带符号数
    jg/jnle label   ;ZF==0&&SF==OF 大于/不小于等于转移
    jng/jle label   ;ZF==1||SF!=OF 不大于/小于等于转移
    jl/jnge label   ;SF!=OF 小于/不大于等于转移
    jnl/jge label   ;SF==OF 不小于/大于等于转移
    ;下面四句用于无符号数
    ja/jnbe label   ;CF==0&&ZF==0 高于/不低于等于转移
    jna/jbe label   ;CF==1||ZF==1 不高于/低于等于转移
    jb/jnae label   ;CF==1 低于/不高于等于转移
    jnb/jae label   ;CF==0 不低于/高于等于转移

    ;下面两句只能使用短转移
    jcxz label  ;cx==0 
    jecxz label ;ecx==0

;循环指令
    ;注意如果ecx/cx初始为0会循环2^32次
    loop label  ;cx-- 若cx!=0转移（或ecx）
    loope/loopz label   ;cx-- 若cx!=0&&zf=1转移
    ;可以用于字符串比较相等，不相等退出
    loopne/loopnz label ;cx-- 若cx!=0&&zf=0转移
    ;可以用于查找数据，找到时退出

;子程序相关
    call dst    ;调用函数，把返回地址压入堆栈再跳转到子程序
    ret         ;返回指令，从栈顶弹出返回地址送入指令指针寄存器
    ret imm     ;返回指令，从栈顶弹出返回地址+imm送入指令指针寄存器
    ;用于废弃主程序传递给子程序的参数

;块操作指令
    ;bwd分别表示byte,word,dword,下略
    movsb,movsw,movsd   ;*edi = *esi
    cmpsb   ;*edi-*esi
    scasb   ;*edi-eax
    stosb   ;*edi = eax
    lodsb   ;eax = *esi
    ;每次运行，esi和edi移动对应的大小（B1W2D4）
    
    ;重复前缀，会改变ecx
    rep     ;重复ecx次，配合movs stos lods
    repz    ;最大重复ecx次，如果zf==0提前终止，配合cmps scas
    repnz   ;最大重复ecx次，如果zf==1提前终止，配合cmps scas

    cld     ;esi edi每次增大对应大小（默认）
    std     ;esi edi每次减小对应大小

    ;使用例
    rep cmpsb