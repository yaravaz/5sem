#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {

    size_t size = 256 * 1024 * 1024;
    int* array = (int*)malloc(size);

    size_t arraySize = size / sizeof(int);

    for (size_t i = 0; i < arraySize; i++) {
        array[i] = (int)i;
    }
    printf("Address: %p\n", (void*)array);
    printf("Array size: %zu\n", arraySize);
    sleep(30);
    free(array);
    return 0;
}