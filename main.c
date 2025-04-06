/* 
Name
Date
Course
*/

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <time.h>

#include "alphabet.h"
#include "information_content.h"
#include "pw_generator.h"

#define MAX_ALPHABET_SIZE 256

// Function prototypes
void parse_arguments(int argc, char *argv[], int *length, int *quantity, int *alphabet_flags, char **alphabet);
void generate_passwords(int length, int quantity, int *alphabet_flags, char *alphabet);

int main(int argc, char *argv[]) {
    // Variables to store command-line arguments
    int length = 0;
    int quantity = 0;
    int alphabet_flags[4] = {0}; // flags for l, u, d, s
    char *alphabet = NULL;

    // Parse command-line arguments
    parse_arguments(argc, argv, &length, &quantity, alphabet_flags, &alphabet);

    // Generate passwords and display their information content
    generate_passwords(length, quantity, alphabet_flags, alphabet);

    // Free dynamically allocated memory for alphabet if needed
    if (alphabet != NULL) {
        free(alphabet);
    }

    return 0;
}
