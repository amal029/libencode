CC=csc
OPTS=-strict-types -specialize -c -O2 -d2
LDFLAGS=
SRCS=decoder.scm encoder.scm util.scm
OBJS=decoder.o encoder.o util.o

all: 
	$(CC) $(OPTS) $(SRCS)

clean:
	rm -rf *.o *.types
