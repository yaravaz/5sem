#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>

#define FILENAME "OS09-07.txt"

int main() {

    int fd = open(FILENAME, O_RDONLY);
    if (fd == -1) {
        perror("Error opening file for reading");
        return 1;
    }

    char buffer[450];
    read(fd, buffer, sizeof(buffer));
    printf("Full text:\n%s\n", buffer);

    lseek(fd, 0, SEEK_SET);
    read(fd, buffer, 26);
    buffer[26] = '\0'; 
    printf("Read from beginning: %s\n", buffer);

    lseek(fd, 28, SEEK_SET);
    read(fd, buffer, 3);
    buffer[3] = '\0';
    printf("Read from offset 28: %s\n", buffer);

    lseek(fd,72, SEEK_CUR);
    read(fd, buffer, 10);
    buffer[10] = '\0';
    printf("Read from current position: %s\n", buffer);

    close(fd);
    return 0;
}
