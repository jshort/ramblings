.DEFAULT_GOAL := all

CC = gcc

CFLAGS  = -Wall -largp -L/usr/local/lib

# the build target executable:
TARGET = cli

all: $(TARGET)

$(TARGET): main.c helpers/cli.c
	$(CC) $(CFLAGS) -o $(TARGET) main.c helpers/cli.c

clean:
	$(RM) $(TARGET)

