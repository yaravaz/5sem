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
	HANDLE heap = HeapCreate(HEAP_NO_SERIALIZE | HEAP_ZERO_MEMORY, 1024 * 1024 * 4, 0);
	sh(heap);

	int* m = (int*)HeapAlloc(heap, HEAP_NO_SERIALIZE | HEAP_ZERO_MEMORY, 300000 * sizeof(int));
	cout << "-- m = " << hex << m << "\n\n";

	sh(heap);

	HeapFree(heap, HEAP_NO_SERIALIZE, m);
	sh(heap);

	HeapDestroy(heap);

	return 0;
}