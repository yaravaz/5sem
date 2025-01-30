#include <stdio.h>
#include <windows.h>
#include <sys/types.h>
#include <process.h>
#include <iostream>

using namespace std;

int main(void) {

    LPCWSTR pr1 = L"D:\\лабы\\oc\\lab3\\os3\\Debug\\OS03_02_1.exe";
    LPCWSTR pr2 = L"D:\\лабы\\oc\\lab3\\os3\\Debug\\OS03_02_2.exe";

    STARTUPINFO si;
    PROCESS_INFORMATION pi1;
    PROCESS_INFORMATION pi2;

    ZeroMemory(&si, sizeof(STARTUPINFO));
    si.cb = sizeof(STARTUPINFO);

    if (CreateProcess(pr1, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE, NULL, NULL, &si, &pi1))
    {
        cout << "OS03_02_1 has been created" << endl;
    }
    else cout << "Error 1" << endl;

    if (CreateProcess(pr2, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE, NULL, NULL, &si, &pi2))
    {
        cout << "OS03_02_2 has been created" << endl;
    }
    else cout << "Error 2" << endl;


    for (int i = 1; i <= 100; i++) {
        printf("%d-%d\n", _getpid(), i);
        Sleep(1000);
    }

    WaitForSingleObject(pi1.hProcess, INFINITE);
    WaitForSingleObject(pi2.hProcess, INFINITE);
    CloseHandle(pi1.hProcess);
    CloseHandle(pi2.hProcess);

    return 0;

}