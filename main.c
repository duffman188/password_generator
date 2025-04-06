/* 
Name
Date
Course
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <ctype.h>
#include "alphabet.h"
#include "information_content.h"
#include "pw_generator.h"

#define MAX_ALPHABET_SIZE 256

// Function prototypes
void parse_arguments(int argc, char *argv[], int *length, int *quantity, int *alphabet_flags, char **alphabet);
void generate_passwords(int length, int quantity, int *alphabet_flags, char *alphabet);

int main(int argc, char *argv[]) {
    int length, quantity;
    char flags[5] = "";  // Buffer for flags
    char alphabet[MAX_ALPHABET_SIZE] = "";

    parse_arguments(argc, argv, &length, &quantity, flags, alphabet);

    // Create the final alphabet using the union of groups and user input
    char available_chars[MAX_ALPHABET_SIZE] = {0};
    get_alphabet_union(flags, alphabet, available_chars);

    // Check if all characters in the alphabet are valid graphical ASCII characters
    validate_alphabet(alphabet);

    // Seed the PRNG to ensure randomness
    srand(time(NULL));  // Randomize seed for different output each time

    // Generate and print passwords
    for (int i = 0; i < quantity; i++) {
        char password[length + 1];  // +1 for the null terminator
        generate_password(password, length, available_chars);  // Generate password

        // Calculate the information content of the generated password
        double info_content = calculate_information_content(password, available_chars);

        // Print the generated password and its information content
        printf("Password %d:\nPassword: %s\nInformation content: %.2f bits\n", i + 1, password, info_content);
    }

    return 0;
}
