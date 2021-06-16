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
    // �ı�������������Էֱ�����ȫ���͹�����
    GLFWwindow* window = glfwCreateWindow(800, 600, "LearnOpenGL", NULL, NULL);
    if (window == NULL)
    {
        std::cout << "Failed to create GLFW window" << std::endl;
        glfwTerminate();
        return -1;
    }
    glfwMakeContextCurrent(window); // ȷ����ǰ������
    // ���ô������Żص�����
    glfwSetFramebufferSizeCallback(window, FrameBufferSizeCallback);
    // ͬ��������ø���ص�����

    // init opengl
    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress))
    {
        std::cout << "Failed to initialize GLAD" << std::endl;
        return -1;
    }

    // ��ʼ��gl�ӿڣ�������viewport transformation
    // ǰ����������ʾ���½����꣨��������Ĵ��ڣ�
    // ������������ʾgl�ӿڴ�С��û����Ժ�window��һ����
    glViewport(0, 0, 800, 600); 

    //��������ImGui
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO(); (void)io;
    ImGui_ImplGlfw_InitForOpenGL(window, true);
    ImGui_ImplOpenGL3_Init("#version 330");
    ImGui::StyleColorsClassic();

    // Application.Init()
    float f;
    ImVec4 clearColor = ImVec4(0.1f, 0.2f, 0.3f, 1.f);
    while (!glfwWindowShouldClose(window)) {
        glfwPollEvents();           // �����¼�����
        
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
        glClear(GL_COLOR_BUFFER_BIT);   // �����ֻ��壬��ɫ���塢��Ȼ����ģ�建��
        ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());
        glfwSwapBuffers(window);    // ����˫����

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