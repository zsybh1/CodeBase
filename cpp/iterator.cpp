#include <iostream>
#include <iterator>
#include <vector>

using namespace std;

int main () {
    // 流迭代器批量输入
    istream_iterator<int> in(cin), eof;
    vector<int> vec(in, eof);

    for (auto i : vec) {
        cout << i << " ";
    }
}