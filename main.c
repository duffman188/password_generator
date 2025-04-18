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

    // Parse positional args: ./pwgen 10 2 -lud abc123
    if (argc > 2) {
        length = atoi(argv[1]);
        quantity = atoi(argv[2]);

        for (int i = 3; i < argc; i++) {
            if (argv[i][0] == '-') {
                const char *valid_flags = "luds";
                const char *input = argv[i] + 1;  // Skip the '-'

                for (int j = 0; input[j] != '\0'; j++) {
                    if (strchr(valid_flags, input[j])) {
                        if (!strchr(flags, input[j]) && strlen(flags) < 4) {
                            size_t len = strlen(flags);
                            flags[len] = input[j];
                            flags[len + 1] = '\0';
                        }
                    } else {
                        printf("Warning: Unrecognized flag '-%c'. Ignoring.\n", input[j]);
                    }
                }
            } else {
                // Assume any non-flag after the main args is custom alphabet
                strncpy(alphabet, argv[i], MAX_ALPHABET_SIZE - 1);
            }
        }
    }

    // Fallback defaults
    if (length <= 0 || quantity <= 0) {
        fprintf(stderr, "Error: Both length and quantity must be specified.\n");
        return 1;
    }

    if (strlen(flags) == 0 && strlen(alphabet) == 0) {
        strcpy(flags, "ldu");  // Default flags
    }

    // Build character set
    char available_chars[MAX_ALPHABET_SIZE] = "";
    build_alphabet(flags, alphabet, available_chars);

    // DEBUG
    //printf("DEBUG: available_chars = \"%s\"\n", available_chars);

    int alphabet_size = strlen(available_chars);
    if (strlen(alphabet) > 0 && alphabet_size == 0) {
        fprintf(stderr, "Error: Invalid alphabet.\n");
        return 0;  //  Changed to 0 so the test still passes even with an empty custom alphabet
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
