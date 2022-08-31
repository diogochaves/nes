all:
	ca65 clearmem.asm -o clearmem.o
	ld65 clearmem.o   -o clearmem.nes -C nes.cfg

clean:
	rm *.o *.nes
