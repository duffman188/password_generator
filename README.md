[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/9L3poPpu)
## Assignment 3: Password Generator

# Background
Password selection is a fundamental aspect of computer security. Over the years, best practices for password selection have evolved. A mixture of alphabetic cases, digits, and symbols is commonly recommended, along with adequate length requirements. However, user-selected passwords often lead to weak choices due to the inherent limitations of human memory and biases.

In this assignment, we explore password generation and security by implementing a program that generates random passwords based on user-defined parameters. This assignment also emphasizes the need for secure password management practices such as using password managers to generate and store complex passwords for each unique account.

Your Program
Your program will generate random passwords based on user-defined parameters. It will be split into multiple source files, following a modular approach, and you will use Make or CMake to manage the build process.

# Requirements
Your program should generate random passwords based on the following command line interface (CLI):

program length quantity [-luds] [alphabet]
Where:

length: the length of each password (an integer).

quantity: the number of passwords to generate (an integer).

-luds flags: Optional flags that specify the alphabet groups to use for password generation. These flags correspond to the character groups:

l: Lowercase letters (a-z).

u: Uppercase letters (A-Z).

d: Digits (0-9).

s: Symbols (e.g., ~!@#$%^&*()_+).

alphabet: A string of custom characters that will be included in the generated password. This allows users to add any characters to the password generation pool.

# Functionality
Union of Alphabet:
The program will combine the character groups from the -luds flags with the user-defined characters in the alphabet. Remove any duplicates when forming the union.

Password Generation:
Generate the specified number of passwords (quantity), each of the given length (length). A random value should be generated, and the corresponding character from the alphabet should be picked for each password.

Information Content Calculation:
For each generated password, compute the information content using the same approach from Assignment 2. Display the information content for each password, calculated in bits.

Valid Character Checking:
Ensure that all characters specified in the alphabet are valid (i.e., they should be graphical ASCII characters). Use the isgraph() function from <ctype.h> to filter out non-graphical characters and print an error if any invalid characters are detected.

# Error Handling:
Handle erroneous inputs such as invalid characters in the alphabet or invalid flag combinations. Provide appropriate error messages.

#  File Organization
At a minimum, your program should have the following files:

main.c: Contains only the main function and handles command-line parsing.

alphabet.c and alphabet.h: Contains code to calculate the union of the alphabet groups and user-specified characters.

information_content.c and information_content.h: Implements the function to calculate the information content of a password.

pw_generator.c and pw_generator.h: Contains the logic for password generation and output.

# Sample Command-Line Usage
$ ./pwgen 8 2 -lu
Using alphabet: ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz
Password 1:
Password: password
Information content: 37.60 bits
Password 2:
Password: Password
Information content: 45.60 bits

# Constraints & Requirements
PRNG: Use the PRNG facilities provided by the C standard library (specifically rand() and srand()) to generate random numbers. Be aware of modulo bias and work around it.

Seeding the PRNG: Ensure you seed the PRNG using srand() with a value that changes (typically the current time).

Character Set Union:
To calculate the union of the alphabet, create an array corresponding to all ASCII characters, initially set to zero. Set to non-zero any character specified either via the -luds flags or user-specified alphabet. This array can then be iterated through to extract the final set of usable characters.

Character Checking:
Ensure that characters passed in the alphabet are graphical ASCII characters. Non-graphical characters should trigger an error.

Flags:
If no -luds flags or alphabet are specified, assume that the user has requested all of the -luds flags (-l, -u, -d, and -s).

 

# Hints:
Use rand() to generate random numbers and srand() to seed the PRNG.

You can store the available characters in a boolean array that represents the presence of each ASCII character.

Be sure to handle errors where users specify non-graphical characters.

You may want to implement functions to:

Parse the command-line arguments.

Calculate the union of the alphabet.

Generate a password by picking random characters from the final alphabet.

Compute the information content of each generated password.

 
