#include <imgui.h>
#include <imgui_impl_glfw.h>
#include <imgui_impl_opengl3.h>

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

    //创建并绑定ImGui
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO(); (void)io;
    ImGui_ImplGlfw_InitForOpenGL(window, true);
    ImGui_ImplOpenGL3_Init("#version 330");
    ImGui::StyleColorsClassic();

    // Application.Init()
    float f;
    ImVec4 clearColor = ImVec4(0.1f, 0.2f, 0.3f, 1.f);
    while (!glfwWindowShouldClose(window)) {
        glfwPollEvents();           // 处理事件队列
        
        ImGui_ImplOpenGL3_NewFrame();
        ImGui_ImplGlfw_NewFrame();
        ImGui::NewFrame();

        // set imgui
        ImGui::Begin("Test Window");
        ImGui::ColorEdit3("clear color", (float*)&clearColor);
        ImGui::End();

        // Application.Update()

        ImGui::Render();
        glClearColor(clearColor.x, clearColor.y, clearColor.z, clearColor.w);   // set clear color
        glClear(GL_COLOR_BUFFER_BIT);   // 有三种缓冲，颜色缓冲、深度缓冲和模板缓冲
        ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());
        glfwSwapBuffers(window);    // 交换双缓冲

        ProcessInput(window);
    }

    ImGui_ImplOpenGL3_Shutdown();
    ImGui_ImplGlfw_Shutdown();
    ImGui::DestroyContext();

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