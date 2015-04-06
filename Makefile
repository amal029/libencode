CC=csc
OPTS=-strict-types -specialize -c -O2 -d2 -X cock
LDFLAGS=
SRCS=decoder.scm encoder.scm util.scm test.scm
OBJS=decoder.o encoder.o util.o test.o

all: 
	$(CC) $(OPTS) $(SRCS)

test:
	$(CC) $(LDFLAGS) $(OBJS) -o $@
	./test

clean:
	rm -rf *.o *.types test
