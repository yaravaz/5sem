#include <iostream>
#include <Windows.h>
using namespace std;

#define PAGES 256
#define MB (1024 * 1024)
#define KB 1024
#define PAGE_SIZE (KB * 4) // 4096 KB

int main()
{
    const size_t totalSize = PAGE_SIZE * PAGES;
    const size_t arraySize = totalSize / sizeof(int);

    LPVOID xmemaddr = VirtualAlloc(NULL, totalSize, MEM_COMMIT, PAGE_READWRITE);
    int* array = (int*)xmemaddr;

    for (int i = 0; i < arraySize; i++)
        array[i] = i;

    int* address = array + 194 * KB + 3822;
    if (!VirtualFree(xmemaddr, NULL, MEM_RELEASE))
        cout << "free virtual memory error" << endl;

    return 0;
}
