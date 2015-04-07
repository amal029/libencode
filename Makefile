CC=csc
OPTS=-strict-types -specialize -c -O2 -d2 -X cock
LDFLAGS=
SRCS=test.scm

all: compile

compile:
	csi -ss libencode.setup compile

install:
	csi -ss libencode.setup install

test:
	$(CC) $(LDFLAGS) $(SRCS) -o $@
	./test

clean:
	rm -rf *.o *.types test *.so *.import.scm
