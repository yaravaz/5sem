#include <iostream>
#include <Windows.h>
using namespace std;
DWORD pid = NULL;

DWORD WINAPI Thread1()
{
	DWORD tid = GetCurrentThreadId();

	for (short i = 0; i < 50; ++i)
	{
		cout << "PID = " << pid << ", ID of thread1 = " << tid << endl;
		Sleep(1000);
	}
	return 0;
}
DWORD WINAPI Thread2()
{
	DWORD tid = GetCurrentThreadId();

	for (short i = 0; i < 125; ++i)
	{
		cout << "PID = " << pid << ", ID of thread2 = " << tid << endl;
		Sleep(1000);
	}
	return 0;
}
int main()
{
	pid = GetCurrentProcessId();
	DWORD mainID = GetCurrentThreadId();
	DWORD os04_05_T1ID = NULL;
	DWORD os04_05_T2ID = NULL;
	HANDLE os04_05_T1 = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)Thread1, NULL, 0, &os04_05_T1ID);
	HANDLE os04_05_T2 = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)Thread2, NULL, 0, &os04_05_T2ID);
	for (short i = 1; i <= 100; ++i)
	{
		if (i == 40)
		{
			TerminateThread(os04_05_T2, 0);
		}
		cout << i << " - PID = " << pid << ", Thread main ID = " << mainID << endl;
		Sleep(1000);
	}
	WaitForSingleObject(os04_05_T1, INFINITE);
	WaitForSingleObject(os04_05_T2, INFINITE);
	CloseHandle(os04_05_T1);
	CloseHandle(os04_05_T2);
	system("pause");
	return 0;
}