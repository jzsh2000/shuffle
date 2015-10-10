shuffle: shuffle.o
	gcc -o bin/shuffle shuffle.o

shuffle.o: shuffle.c
	gcc -c shuffle.c
clean:
	rm -f bin/shuffle shuffle.o
