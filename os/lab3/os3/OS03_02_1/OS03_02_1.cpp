#include <iostream>
#include <Windows.h>

using namespace std;

int main()
{
    for (int i = 0; i < 50; i++)
    {
        cout << GetCurrentProcessId() << endl;
        Sleep(1000);
    }
}
