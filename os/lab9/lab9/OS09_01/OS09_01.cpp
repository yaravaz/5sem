#include <iostream>
#include <Windows.h>
#include <stdio.h>
#include <Shlwapi.h>

#pragma comment(lib, "Shlwapi.lib")

#define PATH L"D:\\лабы\\oc\\lab9\\OS09-01.txt"

using namespace std;

BOOL printFileInfo(LPWSTR fileName) {

    if (!PathFileExists(fileName)) {
        wprintf(L"File does not exist: %s\n", fileName);
        return FALSE;
    }

    HANDLE hFile = CreateFile(fileName, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);

    if (hFile == INVALID_HANDLE_VALUE) {
        wprintf(L"Error CreateFile: %s\n", fileName);
        return FALSE;
    }

    BY_HANDLE_FILE_INFORMATION lpFileInformation;

    if (!GetFileInformationByHandle(hFile, &lpFileInformation)) {
        wprintf(L"Error GetFileInformationByHandle: %s\n", fileName);
        CloseHandle(hFile);
        return FALSE;
    }

    const wchar_t* fileNameOnly = PathFindFileNameW(fileName);
    wprintf(L"File Name: %s\n", fileNameOnly);

    if (lpFileInformation.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) {
        wprintf(L"File Type: folder\n");
    }
    else {
        wprintf(L"File Type: file\n");
    }

    LARGE_INTEGER fileSize;
    fileSize.HighPart = lpFileInformation.nFileSizeHigh;
    fileSize.LowPart = lpFileInformation.nFileSizeLow;
    wprintf(L"File size: %lld byte\n", fileSize.QuadPart);

    SYSTEMTIME creationTime;
    FileTimeToSystemTime(&lpFileInformation.ftCreationTime, &creationTime);
    wprintf(L"Date and time of creating: %02d.%02d.%d %02d:%02d:%02d\n",
        creationTime.wDay, creationTime.wMonth, creationTime.wYear,
        creationTime.wHour, creationTime.wMinute, creationTime.wSecond);

    SYSTEMTIME lastWriteTime;
    FileTimeToSystemTime(&lpFileInformation.ftLastWriteTime, &lastWriteTime);
    wprintf(L"Date and time since last update: %02d.%02d.%d %02d:%02d:%02d\n",
        lastWriteTime.wDay, lastWriteTime.wMonth, lastWriteTime.wYear,
        lastWriteTime.wHour, lastWriteTime.wMinute, lastWriteTime.wSecond);

    CloseHandle(hFile);
    return TRUE;
}

BOOL printFileTxt(LPWSTR fileName) {
    HANDLE hFile = CreateFile(fileName, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);

    if (hFile == INVALID_HANDLE_VALUE) {
        DWORD error = GetLastError();
        wprintf(L"Error CreateFile: %s\n", fileName);
        return FALSE;
    }

    DWORD bytesRead;
    const DWORD bufferSize = 1024;
    char buffer[bufferSize + 1];

    wprintf(L"Text\n");

    while (ReadFile(hFile, buffer, bufferSize, &bytesRead, NULL) && bytesRead > 0) {
        buffer[bytesRead] = '\0';
        printf("%s", buffer);
    }

    CloseHandle(hFile);
    return TRUE;
}

int main() {

    SetConsoleOutputCP(CP_UTF8);

    if (!printFileInfo((LPWSTR)PATH)) {
        printf("Error printFileInfo\n");
    }
    if (!printFileTxt((LPWSTR)PATH)) {
        printf("Error printFileTxt\n");
    }

    return 0;
}