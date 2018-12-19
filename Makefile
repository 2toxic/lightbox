CC?=gcc
AR?=ar
CFLAGS+=-Wall -Wextra -Wshadow -pedantic -Wcast-align -Wformat=2
CFLAGS+=-D_XOPEN_SOURCE
OBJS=src/termbox.o src/utf8.o
DEPS=src/termbox.h bytebuffer.inl input.inl term.inl

DEMO_CFLAGS=-Iinclude -Llib
DEMO_LIBS=-ltermbox

.PHONY: termbox demo clean

termbox: $(OBJS)
	mkdir -p ./include
	mkdir -p ./lib
	$(AR) rcs lib/libtermbox.a $(OBJS)
	cp src/termbox.h include

%.o: src/%.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

demo: termbox
	mkdir -p ./demo
	$(CC) -o ./demo/keyboard src/demo/keyboard.c $(CFLAGS) $(DEMO_CFLAGS) $(DEMO_LIBS)
	$(CC) -o ./demo/paint src/demo/paint.c $(CFLAGS) $(DEMO_CFLAGS) $(DEMO_LIBS)
	$(CC) -o ./demo/output src/demo/output.c $(CFLAGS) $(DEMO_CFLAGS) $(DEMO_LIBS)


clean:
	rm -rf ./include
	rm -rf ./lib
	rm -rf ./demo
	rm -f src/*.o

