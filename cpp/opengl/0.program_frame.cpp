#include <glad/glad.h>  // must put before glfw
#include <GLFW/glfw3.h>

#include <iostream>

void FrameBufferSizeCallback(GLFWwindow* window, int width, int height);
void ProcessInput(GLFWwindow* window);

int main()
{
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    // Set Window attribute like
    // glfwWindowHint(GLFW_RESIZABLE, GL_FALSE);

    // Init Window
    // 改变后两个参数可以分别设置全屏和共享窗口
    GLFWwindow* window = glfwCreateWindow(800, 600, "LearnOpenGL", NULL, NULL);
    if (window == NULL)
    {
        std::cout << "Failed to create GLFW window" << std::endl;
        glfwTerminate();
        return -1;
    }
    glfwMakeContextCurrent(window); // 确定当前上下文
    // 设置窗口缩放回调函数
    glfwSetFramebufferSizeCallback(window, FrameBufferSizeCallback);
    // 同理可以设置更多回调函数

    // init opengl
    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress))
    {
        std::cout << "Failed to initialize GLAD" << std::endl;
        return -1;
    }

    // 初始化gl视口，定义了viewport transformation
    // 前两个参数表示左下角坐标（相对上下文窗口）
    // 后两个参数表示gl视口大小（没错可以和window不一样）
    glViewport(0, 0, 800, 600); 

    // Application.Init()

    while (!glfwWindowShouldClose(window)) {
        glClearColor(.1f, .2f, .3f, 1.f);   // set clear color
        glClear(GL_COLOR_BUFFER_BIT);   // 有三种缓冲，颜色缓冲、深度缓冲和模板缓冲

        // Application.Update();

        glfwSwapBuffers(window);    // 交换双缓冲
        glfwPollEvents();           // 处理事件队列
        ProcessInput(window);
    }

    glfwTerminate();
    return 0;
}

void FrameBufferSizeCallback(GLFWwindow* window, int width, int height) {
    glViewport(0, 0, width, height);
}

void ProcessInput(GLFWwindow* window) {
    if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
        glfwSetWindowShouldClose(window, true);
    }
}