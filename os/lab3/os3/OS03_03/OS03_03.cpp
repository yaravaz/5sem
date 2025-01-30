#include <iostream>
#include <Windows.h>
#include <iomanip>
#include <TlHelp32.h>
#include <tlhelp32.h>

using namespace std;

int main()
{
	DWORD pid = GetCurrentProcessId();
	HANDLE snap = CreateToolhelp32Snapshot(TH32CS_SNAPALL, 0);

	PROCESSENTRY32 peProcessEntry;
	peProcessEntry.dwSize = sizeof(PROCESSENTRY32);
    wcout << setw(40) << L"Name"  << L"|"
        << setw(10) << L"PID" << L"|"
        << L"Parent ID |" << endl;

    try {
        if (!Process32First(snap, &peProcessEntry))
            throw L"Process32First";

        do {
            wcout << setw(40) << peProcessEntry.szExeFile << L"|"
                << setw(10) << peProcessEntry.th32ProcessID << L"|"
                << setw(10) << peProcessEntry.th32ParentProcessID << L"|" << endl;

        } while (Process32Next(snap, &peProcessEntry));
	}
	catch (char* msg)
	{
		wcout << L"ERROR: " << msg << endl;
	}

}

