CC = gcc
CFLAGS = -Wall -g
OBJS = main.o alphabet.o information_content.o pw_generator.o

all: pwgen

pwgen: $(OBJS)
	$(CC) $(OBJS) -o pwgen

main.o: main.c alphabet.h information_content.h pw_generator.h
	$(CC) $(CFLAGS) -c main.c

alphabet.o: alphabet.c alphabet.h
	$(CC) $(CFLAGS) -c alphabet.c

information_content.o: information_content.c information_content.h
	$(CC) $(CFLAGS) -c information_content.c

pw_generator.o: pw_generator.c pw_generator.h
	$(CC) $(CFLAGS) -c pw_generator.c

clean:
	rm -f *.o pwgen
