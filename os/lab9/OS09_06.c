#include <stdio.h>
#include <stdlib.h>

void sortLines(const char* inputFile, const char* outputFile, int isOdd) {
    FILE* file = fopen(inputFile, "r");
    if (!file) {
        perror("error fopen input");
        return;
    }

    FILE* output = fopen(outputFile, "w");
    if (!output) {
        perror("error output");
        fclose(file);
        return;
    }

    char line[256];
    int lineNumber = 1;

    while (fgets(line, sizeof(line), file)) {
        if ((lineNumber % 2 == 1 && isOdd) || (lineNumber % 2 == 0 && !isOdd)) {
            fputs(line, output);
        }
        lineNumber++;
    }

    fclose(file);
    fclose(output);
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <integer>\n", argv[0]);
        return 1;
    }

    int number = atoi(argv[1]);
    const char* inputFile = "OS09-05.txt";

    if (number % 2 == 1) {
        sortLines(inputFile, "OS09_06_1.txt", 1);
        printf("created OS09_06_1.txt with odd lines.\n");
    }
    else {
        sortLines(inputFile, "OS09_06_2.txt", 0);
        printf("created OS09_06_2.txt with even lines.\n");
    }

    return 0;
}
