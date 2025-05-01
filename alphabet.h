// alphabet.h

#ifndef ALPHABET_H
#define ALPHABET_H

#define MAX_ALPHABET_SIZE 128

// Function to construct the available character set from flags and custom alphabet
void get_alphabet_union(const char *flags, const char *user_alphabet, char *available_chars);

// Function to validate the user-provided custom alphabet
void validate_alphabet(const char *alphabet);

// ✅ Add this declaration so main.c knows about it
void build_alphabet(const char *flags, const char *custom, char *result);

#endif // ALPHABET_H