#include <stdio.h>
#include <stdlib.h>

int main() {
    const char* fileName = "OS09-05.txt";

    FILE* file = fopen(fileName, "r");
    if (!file) {
        perror("Error opening file");
        return 0;
    }

    int lineCount = 0;
    char ch;

    while ((ch = fgetc(file)) != EOF) {
        if (ch == '\n') {
            lineCount++;
        }
    }
    fclose(file);
    printf("%d lines\n", lineCount);

    return 0;
}
