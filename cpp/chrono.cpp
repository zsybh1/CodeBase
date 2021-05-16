#include <chrono>
#include <iostream>

int main() {
    auto begin = std::chrono::system_clock::now();
    // code to time
    auto end = std::chrono::system_clock::now();;
    auto duration = std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
    std::cout << double(duration.count()) / std::chrono::nanoseconds::period::den << std::endl;

    {
        // 简化用法
        using namespace std;
        using namespace std::chrono;

        auto begin = system_clock::now();
        // code to time
        auto end = system_clock::now();
        auto duration = duration_cast<nanoseconds>(end - begin);

        cout << double(duration.count()) / nanoseconds::period::den << endl;
    }
}