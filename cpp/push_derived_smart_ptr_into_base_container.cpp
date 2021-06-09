// 往基类智能指针容器中加入子类对象的方法
#include <vector>
#include <type_traits>
#include <memory>

struct Object{
    virtual ~Object() = default;
};

struct Point : public Object{
    float x, y;
    Point(float _x, float _y):x(_x), y(_y){}
};

struct Scene{
    std::vector<std::shared_ptr<Object>> Objs;

    // 对于以对象方式传入，使用这个方法
    // 需要对象有拷贝构造函数，注意浅拷贝问题
    // 碎片较多
    template <typename ObjImpl>
    void AddObject(ObjImpl && obj){
        Objs.push_back(std::shared_ptr<Object>(new typename std::remove_reference<ObjImpl>::type(obj)));
    }

    // 对于智能指针的特化，采用共享方式保存
    template <typename ObjImpl>
    void AddObject(std::shared_ptr<ObjImpl> obj) {
        Objs.push_back(obj);
    }

    // 可读性较好的临时构造方法
    template<typename ObjImpl, typename... Args>
    void AddObject(Args&&...args) {
        Objs.push_back(std::make_shared<ObjImpl>(std::forward<Args>(args)...));
    }
};

int main() {
    Scene scene;

    // 对象传入，拷贝构造
    scene.AddObject(Point(1, 2));
    Point p1(1, 3);
    scene.AddObject(p1);
    auto p2 = std::make_shared<Point>(1, 4);
    scene.AddObject(*p2);

    // 智能指针传入，共享保存
    scene.AddObject(std::make_shared<Point>(2, 1));
    auto p3 = std::make_shared<Point>(2, 2);
    scene.AddObject(p3);

    // 临时构造
    scene.AddObject<Point>(3, 3);
    Point p4(3, 4);
    scene.AddObject<Point>(p4);
}