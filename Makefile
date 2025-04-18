CC = gcc
CFLAGS = -Wall -g
OBJS = main.o alphabet.o information_content.o pw_generator.o

.PHONY: all clean test run

all: pwgen

pwgen: $(OBJS)
	$(CC) $(OBJS) -o $@ -lm

main.o: main.c alphabet.h information_content.h pw_generator.h
	$(CC) $(CFLAGS) -c $< -o $@

alphabet.o: alphabet.c alphabet.h
	$(CC) $(CFLAGS) -c $< -o $@

information_content.o: information_content.c information_content.h
	$(CC) $(CFLAGS) -c $< -o $@

pw_generator.o: pw_generator.c pw_generator.h
	$(CC) $(CFLAGS) -c $< -o $@

test: all
	chmod +x test.sh
	./test.sh

run: pwgen
	./pwgen 10 2 -lud

clean:
	rm -f *.o pwgen
