CC=csc
OPTS=-strict-types -specialize -c -O2 -d2 -X cock
LDFLAGS=
SRCS=test.scm

all: 
	csi -s libencode.setup

test:
	$(CC) $(LDFLAGS) $(SRCS) -o $@
	./test

clean:
	rm -rf *.o *.types test *.so *.import.scm
