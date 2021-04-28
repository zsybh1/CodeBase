;模块化程序设计

;声明外部变量
extrn x:dword
extern msg:byte ;两者等效

;声明可以被其他模块调用
public x, msg, subproc  ;可以变量或子程序名

;声明子程序
printf proto C :dword, :vararg
subproc proto stdcall :dword, :dword