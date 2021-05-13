// bitset
#include <bitset>
#include <string>
int main () {
    int a = 0;

    // a转换为32位二进制字符串
    std::string str = std::bitset<32>(a).to_string();

    // 去除前导零
    str = a != 0 ? str.substr(str.find_first_not_of('0')) : "0";
}
