CFLAGS+=-I/usr/include/python2.7 -g -O0 -Wall -std=c99
LDLIBS+=-lpython2.7

GENERATED=str list *.so woex woexp.c filetree_walk.c

all:	str list repeat.so woex woexp.so filetree_walk.so

%.c:	%.pyx
	cython $< -o $@

%.so: %.c
	$(CC) $< $(CFLAGS) -o $@ -shared -fPIC $(LDFLAGS) $(LDLIBS)

clean:
	rm -f $(GENERATED) *.o

demo:	all
	./str qwert 1 3 4
	python testrepeat.py
	./woex
	python testwoexp.py
	python test-ftw.py

test:	all
	valgrind ./str qwert 1 3 4
	valgrind python testrepeat.py
	python -c 'import repeat; print dir(repeat); help(repeat)' | cat
	valgrind python testwoexp.py
	python -c 'import woexp; print dir(woexp); help(woexp)' | cat
	valgrind ./list abadsf asdf \(1,2,3\), 1, 4 1 4 3
	valgrind python test-ftw.py
