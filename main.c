// main.c

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "alphabet.h"
#include "information_content.h"
#include "pw_generator.h"

#define MAX_ALPHABET_SIZE 128

// Function to parse command-line arguments
void parse_arguments(int argc, char *argv[], int *length, int *quantity, char *flags, char *alphabet);

int main(int argc, char *argv[]) {
    int length, quantity;
    char flags[5] = "";
    char alphabet[MAX_ALPHABET_SIZE] = "";

    // Parse command-line arguments
    parse_arguments(argc, argv, &length, &quantity, flags, alphabet);

    // Create the available characters array (to be used for password generation)
    char available_chars[MAX_ALPHABET_SIZE] = {0};

    // Determine available characters based on flags and custom alphabet

    // Seed random number generator

    // Generate and display passwords
    for (int i = 0; i < quantity; i++) {
        char password[length + 1];
        // Generate the password

        // Calculate information content (entropy) and display the result
    }

    return 0;
}
