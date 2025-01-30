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
DWORD getThreadPriority(int i)
{
	switch (i)
	{
	case 1: return THREAD_PRIORITY_LOWEST;
	case 2: return THREAD_PRIORITY_BELOW_NORMAL;
	case 3: return THREAD_PRIORITY_NORMAL;
	case 4: return THREAD_PRIORITY_ABOVE_NORMAL;
	case 5: return THREAD_PRIORITY_HIGHEST;
	case 6: return THREAD_PRIORITY_IDLE;
	default: throw "???";
	}
}
void TA()
{
	DWORD pid = GetCurrentProcessId();
	DWORD tid = GetCurrentThreadId();
	HANDLE hp = GetCurrentProcess();
	HANDLE ht = GetCurrentThread();
	for (int i = 0; i < 1000000; i++)
	{
		if (i % 1000 == 0 && i != 0)
		{
			Sleep(200);
			cout << "Iteration number: " << dec << i << endl;
			cout << "Main PID: " << dec << pid << endl;
			cout << "Main TID: " << dec << tid << endl;
			DWORD processPriority = GetPriorityClass(hp);

			switch (processPriority)
			{
			case IDLE_PRIORITY_CLASS: cout << "Process priority: IDLE\n";	break;
			case BELOW_NORMAL_PRIORITY_CLASS: cout << "Process priority: BELOW_NORMA\n";	break;
			case NORMAL_PRIORITY_CLASS:	cout << "Process priority: NORMAL\n"; break;
			case ABOVE_NORMAL_PRIORITY_CLASS: cout << "Process priority: ABOVE_NORMAL\n";	break;
			case HIGH_PRIORITY_CLASS: cout << "Process priority: HIGH\n"; break;
			case REALTIME_PRIORITY_CLASS: cout << "Process priority: REALTIME\n";	break;
			default: cout << "Process priority: ???\n"; break;
			}
			DWORD threadPriority = GetThreadPriority(ht);
			switch (threadPriority)
			{
			case THREAD_PRIORITY_LOWEST: cout << "Thread priority: LOWEST\n"; break;
			case THREAD_PRIORITY_BELOW_NORMAL: cout << "Thread priority: TBELOW_NORMAL\n"; break;
			case THREAD_PRIORITY_NORMAL: cout << "Thread priority: NORMAL\n"; break;
			case THREAD_PRIORITY_ABOVE_NORMAL:cout << "Thread priority: ABOVE_NORMAL\n"; break;
			case THREAD_PRIORITY_HIGHEST: cout << "Thread priority: HIGHEST\n"; break;
			case THREAD_PRIORITY_IDLE: cout << "Thread priority: IDLE\n"; break;
			default:cout << "Thread priority: ???\n"; break;
			}
			DWORD icpu = SetThreadIdealProcessor(ht, MAXIMUM_PROCESSORS);
			cout << "Thread IdealProcessor: " << dec << icpu << endl;
		}
	}
	cout << "End of routine" << endl;
}
int main(int argc, char* argv[])
{
	try
	{
		if (argc == 5)
		{
			HANDLE hp = GetCurrentProcess();
			DWORD mask = atoi(argv[1]);
			DWORD processPriority = atoi(argv[2]);
			DWORD priority1 = atoi(argv[3]);
			DWORD priority2 = atoi(argv[4]);
			if (!SetProcessAffinityMask(hp, mask))
				throw "SetProcessAffinityMask error";
			cout << "Current affinity mask: " << showbase << hex << mask << endl;
			cout << "Process priority: " << getProcessPriority(processPriority) << endl;
			cout << "Thread priority 1: " << getThreadPriority(priority1) << endl;
			cout << "Thread priority 2: " << getThreadPriority(priority2) << endl;
			DWORD childId_T1, childId_T2 = NULL;
			HANDLE hChild1 = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)TA, NULL, CREATE_SUSPENDED, &childId_T1);
			HANDLE hChild2 = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)TA, NULL, CREATE_SUSPENDED, &childId_T2);
			SetThreadPriority(hChild1, getThreadPriority(priority1));
			SetThreadPriority(hChild2, getThreadPriority(priority2));
			ResumeThread(hChild1);
			ResumeThread(hChild2);
			WaitForSingleObject(hChild1, INFINITE);
			WaitForSingleObject(hChild2, INFINITE);
			CloseHandle(hChild1);
			CloseHandle(hChild2);
		}
		else
			cout << "Need for 4 args" << endl;
	}
	catch (string err)
	{
		cout << err << endl;
	}
}

