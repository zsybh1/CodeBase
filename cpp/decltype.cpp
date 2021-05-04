//decltype保留const和&
const int& a = 0;
decltype(a) b = 0;  //const int& b
//decltype((type))会得到type&
int c = 0;
decltype((c)) d = c;    //int& d

//最常用于推导返回值类型
template <typename _Tx, typename _Ty>
auto multiply(_Tx x, _Ty y)->decltype(x*y)
{
    return x*y;
}