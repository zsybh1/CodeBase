;浮点数在汇编中的使用

;浮点数使用浮点寄存器栈，这是一个循环栈
;使用st(0) ~ st(7)来调用其中的内容，st(0)为栈顶
;浮点数也有自己的标志寄存器，但似乎一般用不上

;浮点数据类型
    real4 / dword   ;32位单精度
    real8 / qword   ;64位双精度
    real10 / tbyte  ;80位扩展精度
    ;数据定义时可以使用e代表整数

;数据传送指令
    fld src     ;将src加载到st(0)
    fst dest    ;将st(0)保存到dest中，st(0)不出栈
    fstp dest   ;将st(0)保存到dest中，st(0)出栈

;常数加载指令
    fld1    ;加载1.0
    fldz    ;加载0.0
    fldpi   ;加载π
    fldl2t  ;加载log2(10)
    fldl2e  ;加载log2(e)
    fldlg2  ;加载lg2
    fldln2  ;加载ln2

;算术运算指令
    ;FADD FSUB FMUL FDIV四类指令使用方式类似，以fsub为例
    fsub        ;st(1) -= st(0), pop()
    fsub src    ;st(0) -= src
    fsub st(i), st(0)   ;st(i) -= st(0)
    fsub st(0), st(i)   ;st(0) -= st(i)
    fsubp st(i), st(0)  ;st(i) -= st(0), pop()

    fsqrt   ;st(0) = sqrt(st(0))
    fscale  ;st(0) = st(0)*2^int(st(1))
    fprem   ;st(0) %= st(1)
    fabs    ;st(0) = |st(0)|
    fchs    ;st(0) = -st(0)

    fsin    ;st(0) = sin(st(0))
    fcos    ;st(0) = cos(st(0))
    fptan   ;st(0) = tan(st(0))
    fpatan  ;st(0) = arctan(st(0))
    f2xm1   ;st(0) = 2^st(0) - 1 当|st(0)| < 1

;浮点比较指令
    fcom        ;st(0) - st(1)
    fcom src    ;st(0) - src
    fcom st(i)  ;st(0) - st(i)
    fcomp       ;st(0) - st(1), pop()
    fcomp src   ;st(0) - src, pop()
    fcomp st(i) ;st(0) - st(i), pop()
    ;随后可以使用ja jnbe jb jnae je jz指令完成跳转，别的指令不确定

;FPU控制指令
    finit       ;初始化FPU
    fldcw src   ;从src装入FPU的控制字
    fstcw dest  ;保存状态字的值到dest