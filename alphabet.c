// alphabet.c

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include "alphabet.h"

void build_alphabet(const char *flags, const char *custom, char *result) {
    const char *lower = "abcdefghijklmnopqrstuvwxyz";
    const char *upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const char *digits = "0123456789";
    const char *symbols = "!@#$%^&*()_+-=[]{}|;:',.<>/?";

    int ascii[128] = {0};  // Track characters to avoid duplicates

    // Add characters from -luds flags
    if (strchr(flags, 'l')) {
        for (int i = 0; lower[i]; i++) ascii[(unsigned char)lower[i]] = 1;
    }
    if (strchr(flags, 'u')) {
        for (int i = 0; upper[i]; i++) ascii[(unsigned char)upper[i]] = 1;
    }
    if (strchr(flags, 'd')) {
        for (int i = 0; digits[i]; i++) ascii[(unsigned char)digits[i]] = 1;
    }
    if (strchr(flags, 's')) {
        for (int i = 0; symbols[i]; i++) ascii[(unsigned char)symbols[i]] = 1;
    }

    // Add custom characters if graphical
    if (custom && strlen(custom) > 0) {
        for (int i = 0; custom[i]; i++) {
            unsigned char c = (unsigned char)custom[i];
            if (isgraph(c)) {
                ascii[c] = 1;
            } else {
                printf("Warning: Non-graphical character detected, skipping.\n");
            }
        }
    }

    // Populate result string from ascii map
    int pos = 0;
    for (int i = 0; i < 128 && pos < MAX_ALPHABET_SIZE - 1; i++) {
        if (ascii[i]) {
            result[pos++] = (char)i;
        }
    }
    result[pos] = '\0';
}
