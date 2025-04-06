CC = gcc
CFLAGS = -Wall -Wextra -std=c11 -g

# Source files
SRC = main.c alphabet.c information_content.c pw_generator.c
OBJ = $(SRC:.c=.o)
EXEC = pwgen

# Output and test files
TEST_SCRIPT = test.sh

# Default target: build the program
all: $(EXEC)

# Rule for building the executable
$(EXEC): $(OBJ)
	$(CC) $(OBJ) -o $(EXEC)

# Rule for compiling .c files into .o files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean up compiled files
clean:
	rm -f $(OBJ) $(EXEC)

# Run tests after building
test: $(EXEC)
	@echo "Running tests..."
	@chmod +x $(TEST_SCRIPT)
	@./$(TEST_SCRIPT)

# Rebuild everything (clean and then all)
rebuild: clean all

# Phony targets
.PHONY: all clean test rebuild
