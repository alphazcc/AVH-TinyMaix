#include "FreeRTOS.h"
#include "task.h"
#include "mnist_data.h"

int mnist(const uint8_t *data);
int mbnet(int argc, char** argv);

static void tinymaix_mnist(void *parameter)
{
    int i = 0;

    printf("\r\n------ MNIST example run started! ------\r\n");

    for(i = 0; i < 10; i++)
    {
        printf("\r\n------ Image %d ------\r\n", i + 1);
        mnist(mnist_data[i]);
    }

    printf("\r\n------ MNIST example run completed! ------\r\n");
}

static void tinymaix_mbnet(void *parameter)
{
    printf("\r\n------ MBNET example run started! ------\r\n");

    mbnet(0, NULL);

    printf("\r\n------ MBNET example run completed! ------\r\n");
}

static void tinymaix_examples(void *parameter)
{
    tinymaix_mnist(NULL);
    tinymaix_mbnet(NULL);
}

int user_app_init(void)
{
    printf("\r\n------ this is the user application ------\r\n");
    xTaskCreate(tinymaix_examples, "tinymaix_examples", 128, NULL, 4, NULL);
    return 0;
}
