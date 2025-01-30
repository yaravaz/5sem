#include <iostream>
#include <cstdlib>
#include "Windows.h"

using namespace std;

DWORD getProcessPriority(int i) 
{
	switch (i)
	{
	case 1: return IDLE_PRIORITY_CLASS;
	case 2: return BELOW_NORMAL_PRIORITY_CLASS;
	case 3: return NORMAL_PRIORITY_CLASS;
	case 4: return ABOVE_NORMAL_PRIORITY_CLASS;
	case 5: return HIGH_PRIORITY_CLASS;
	case 6: return REALTIME_PRIORITY_CLASS;
	default: throw "???";
	}
}
int main(int argc, char* argv[])
{
    try
    {
		if (argc == 4)
		{
			HANDLE hp = GetCurrentProcess();
			DWORD_PTR mask = atoi(argv[1]);
			DWORD priority1 = atoi(argv[2]);
			DWORD priority2 = atoi(argv[3]);
			if (!SetProcessAffinityMask(hp, mask)) throw "Error";
			cout << "Current affinity mask: " << showbase << hex << mask << endl;
			cout << "Process priority 1: " << getProcessPriority(priority1) << endl;
			cout << "Process priority 2: " << getProcessPriority(priority2) << endl;
			LPCWSTR path = L"D:\\лабы\\oc\\lab5\\lab5\\Debug\\os05_02x.exe";
			STARTUPINFO si1, si2;
			PROCESS_INFORMATION pi1, pi2;
			ZeroMemory(&si1, sizeof(STARTUPINFO));
			ZeroMemory(&si2, sizeof(STARTUPINFO));
			si1.cb = sizeof(STARTUPINFO);
			si2.cb = sizeof(STARTUPINFO);

			if (CreateProcess(path, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE | getProcessPriority(priority1), NULL, NULL, &si1, &pi1))
				cout << "os5_02-1 was created\n";
			else cout << "error with creating os05_02-1\n";

			if (CreateProcess(path, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE | getProcessPriority(priority2), NULL, NULL, &si2, &pi2))
				cout << "os5_02-2 was created\n";
			else cout << "error with creating os05_02-2\n";

			WaitForSingleObject(pi1.hProcess, INFINITE);
			WaitForSingleObject(pi2.hProcess, INFINITE);
			CloseHandle(pi1.hProcess);
			CloseHandle(pi2.hProcess);
		}
		else
			cout << "Need for 3 args" << endl;
	}
	catch (string err)
	{
		cout << err << endl;
	}
}
