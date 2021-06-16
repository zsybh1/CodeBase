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

    // Application.Init()

    while (!glfwWindowShouldClose(window)) {
        glClearColor(.1f, .2f, .3f, 1.f);   // set clear color
        glClear(GL_COLOR_BUFFER_BIT);   // �����ֻ��壬��ɫ���塢��Ȼ����ģ�建��

        // Application.Update();

        glfwSwapBuffers(window);    // ����˫����
        glfwPollEvents();           // �����¼�����
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