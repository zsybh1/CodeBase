#include <iostream>
#include <iterator>
#include <vector>
#include <algorithm>

using namespace std;

int main () {
    // 流迭代器批量输入
    istream_iterator<int> in(cin), eof; // cin也可以替换成fstream
    vector<int> vec(in, eof);

    // 流迭代器批量输出
    ostream_iterator<int> out(cout, " ");
    cout << endl;   // 刷新输出流
}