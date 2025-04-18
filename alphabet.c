// alphabet.c

#include <stdio.h>
#include <string.h>     // For strlen, strncat, strchr
#include "alphabet.h"   // For MAX_ALPHABET_SIZE and function declarations
#include <ctype.h>
void build_alphabet(const char *flags, const char *custom, char *result) {
    const char *lower = "abcdefghijklmnopqrstuvwxyz";
    const char *upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const char *digits = "0123456789";
    const char *symbols = "!@#$%^&*()_+-=[]{}|;:',.<>/?";

    result[0] = '\0';

    // Handle custom alphabet
    if (custom && strlen(custom) > 0) {
        int pos = 0;
        for (int i = 0; custom[i] != '\0' && pos < MAX_ALPHABET_SIZE - 1; i++) {
            if (isgraph((unsigned char)custom[i])) {
                result[pos++] = custom[i];
            } else {
                printf("Warning: Non-graphical character detected, skipping.\n");
            }
        }
        result[pos] = '\0';
        return;
    }

    // Otherwise build from flags
    if (strchr(flags, 'l')) strncat(result, lower, MAX_ALPHABET_SIZE - strlen(result) - 1);
    if (strchr(flags, 'u')) strncat(result, upper, MAX_ALPHABET_SIZE - strlen(result) - 1);
    if (strchr(flags, 'd')) strncat(result, digits, MAX_ALPHABET_SIZE - strlen(result) - 1);
    if (strchr(flags, 's')) strncat(result, symbols, MAX_ALPHABET_SIZE - strlen(result) - 1);
}

// Optional stub for alternate logic (can be integrated with build_alphabet)
void get_alphabet_union(const char *flags, const char *user_alphabet, char *available_chars) {
    // Optional: Implement if needed separately from build_alphabet
}

// Optional stub for validation
void validate_alphabet(const char *alphabet) {
    // Optional: Add validation logic to check for invalid or repeated characters
}
