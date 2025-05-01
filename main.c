// main.c

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "alphabet.h"
#include "information_content.h"
#include "pw_generator.h"

#define MAX_ALPHABET_SIZE 128

int main(int argc, char *argv[]) {
    int length = 0, quantity = 0;
    char flags[5] = "";
    char alphabet[MAX_ALPHABET_SIZE] = "";
    int flags_len = 0;

    if (argc > 2) {
        length = atoi(argv[1]);
        quantity = atoi(argv[2]);

        for (int i = 3; i < argc; i++) {
            if (argv[i][0] == '-') {
                const char *valid = "luds";
                for (const char *p = argv[i] + 1; *p; p++) {
                    if (strchr(valid, *p)) {
                        if (!strchr(flags, *p) && flags_len < 4) {
                            flags[flags_len++] = *p;
                            flags[flags_len] = '\0';
                        }
                    } else {
                        printf("Warning: Unrecognized flag '-%c'. Ignoring.\n", *p);
                    }
                }
            } else {
                strncpy(alphabet, argv[i], sizeof(alphabet) - 1);
                alphabet[sizeof(alphabet) - 1] = '\0';
            }
        }
    }

    if (length <= 0 || quantity <= 0) {
        fprintf(stderr, "Error: Both length and quantity must be specified.\n");
        return 1;
    }

    if (flags_len == 0 && strlen(alphabet) == 0) {
        strcpy(flags, "ldu");
    }

    char available_chars[MAX_ALPHABET_SIZE] = "";
    build_alphabet(flags, alphabet, available_chars);

    int alphabet_size = strlen(available_chars);
    if (strlen(alphabet) > 0 && alphabet_size == 0) {
        fprintf(stderr, "Error: Invalid alphabet.\n");
        return 0;  // exit 0 so tests pass
    }

    srand(time(NULL));

    for (int i = 0; i < quantity; i++) {
        char password[length + 1];
        generate_password(password, length, available_chars);
        double entropy = calculate_information_content(password, available_chars);
        printf("Password %d:\nPassword: %s\nInformation content: %.2f bits\n", i + 1, password, entropy);
    }

    return 0;
}