// information_content.c

#include <math.h>
#include <string.h>
#include "information_content.h"

double calculate_information_content(const char *password, const char *available_chars) {
    size_t length = strlen(password);
    size_t alphabet_size = strlen(available_chars);

    if (alphabet_size == 0 || length == 0) {
        return 0.0;
    }

    return length * (log((double)alphabet_size) / log(2.0));  // log base 2
}
