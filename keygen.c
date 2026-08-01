#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void genkey(int length) {
    char charset[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    for (int i = 0; i < length; i++) {
        int index = rand() % (sizeof(charset) - 1);
        printf("%c", charset[index]);
        if ((i + 1) % 4 == 0 && i + 1 < length) {
            printf("-");
        }
    }
    printf("\n");
}

int main() {
    srand(time(NULL));
    printf("Generated Key: ");
    genkey(16);
    return 0;
}