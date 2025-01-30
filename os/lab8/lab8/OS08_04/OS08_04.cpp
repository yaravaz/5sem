#include <iostream>
#include <Windows.h>

using namespace std;

void sh(HANDLE pheap) {
	PROCESS_HEAP_ENTRY phe;
	phe.lpData = NULL;
	while (HeapWalk(pheap, &phe))
	{
		cout << "-- address = " << hex << phe.lpData 
								<< ", size = " << dec << phe.cbData 
								<< ((phe.wFlags & PROCESS_HEAP_REGION) ? " R" : "") 
								<< ((phe.wFlags & PROCESS_HEAP_UNCOMMITTED_RANGE) ? " U" : "")
								<< ((phe.wFlags & PROCESS_HEAP_ENTRY_BUSY) ? " B" : "") 
								<< "\n";
	}	
	cout << "-----------------------------------------\n\n";
}

int main()
{
    HANDLE pheap = GetProcessHeap();

    sh(pheap);

	int size = 300000;
	int* m = new int[size];
	cout << "-- m = " << hex << m << ", size = " << dec << size << "\n\n";

	sh(pheap);

	system("pause");
	return 0;
}