#include <stdio.h>
#include <windows.h>
#include <sys/types.h>

int main(void) {
    for (int i = 1; i <= 1000; i++) {
        printf("%d-%d\n", getpid(), i);
        Sleep(2000);
    }
    return 0;
}