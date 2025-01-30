#include <stdio.h>
#include <windows.h>
#include <sys/types.h>
#include <process.h>

int main(void) {
    for (int i = 1; i <= 1000; i++) {
        printf("%d-%d\n", _getpid(), i);
        Sleep(1000);
    }
    return 0;
}