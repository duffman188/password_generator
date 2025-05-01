// pw_generator.c

#include <stdlib.h>
#include <string.h>
#include "pw_generator.h"

void generate_password(char *password, int length, const char *available_chars) {
    size_t alphabet_size = strlen(available_chars);

    if (alphabet_size == 0) {
        password[0] = '\0';  // fail-safe
        return;
    }

    for (int i = 0; i < length; i++) {
        int index = rand() % alphabet_size;
        password[i] = available_chars[index];
    }

    password[length] = '\0';  // null-terminate
}
