INCLUDE=-Iinclude/
CC=gcc
LIBS=$(shell pkg-config sdl2 --libs)
SDL_FLAGS=$(shell pkg-config sdl2 --cflags)
CFLAGS=-Wall -Wextra -pedantic -std=c99 $(SDL_FLAGS)

SRC=src
SRCS=$(wildcard $(SRC)/*.c)

INC=src
HDRS=$(wildcard $(INC)/*.h)

OBJ=obj
OBJS=$(patsubst $(SRC)/%.c,$(OBJ)/%.o,$(SRCS))

BIN_DIR=bin
BIN=bin/cell-auto

.PHONY: all clean

all: $(BIN)

$(BIN): $(OBJS) $(OBJ) $(BIN_DIR)
	$(CC) $(CFLAGS) $(OBJS) -o $@ $(LIBS)

$(OBJ)/%.o: $(SRC)/%.c $(OBJ)
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJ):
	mkdir -p $@

$(BIN_DIR):
	mkdir -p $@

clean:
	$(RM) -r $(OBJ)
	$(RM) -r $(BIN_DIR)
