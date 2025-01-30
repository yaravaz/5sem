#include <stdio.h>
#include <time.h>
#include <unistd.h>

int main() {
    long iters = 0;
    time_t startTime, currentTime;

    time(&startTime);

    while (1) {
        iters++;

        currentTime = time(NULL);
        double elapsedTime = difftime(currentTime, startTime);
        if (elapsedTime >= 2.0) {
            printf("2 seconds have passed: %ld\n", iters);
            printf("Time: %.0f sec\n", elapsedTime);

            startTime = currentTime;
        }
    }

    return 0;
}