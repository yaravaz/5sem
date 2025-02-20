#include <stdio.h>
#include <time.h>
#include <unistd.h>
#include <pthread.h>

pthread_mutex_t mutex;

void* thread(void* name) {

    for (int i = 1; i <= 90; ++i) {
        if (i == 30) {
            pthread_mutex_lock(&mutex);
        } else if (i == 60) {
            pthread_mutex_unlock(&mutex);
        }

        printf( "%s: %d \n", (char*)name, i);

        usleep(100000);
    }
    
    pthread_exit("Child Thread");
}

int main() {
    pthread_t thread1, thread2;

    pthread_mutex_init(&mutex, NULL);

    pthread_create(&thread1, NULL, thread, (void*)"A");
    pthread_create(&thread2, NULL, thread, (void*)"B");

    thread((void*)"main");

    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);

    pthread_mutex_destroy(&mutex);
    return 0;
}