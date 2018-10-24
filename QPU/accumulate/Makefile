OBJS=driver2.o mailbox.o qpu.o
LINKS=-ldl
.PHONY: all clean

all: driver2 accumulate2.bin

clean:
	rm *.o *.bin driver2

driver2: $(OBJS)
	g++ -g -O3 -o driver2 $(OBJS) $(LINKS)

accumulate2.bin: accumulate2.asm
	vc4asm -o accumulate2.bin accumulate2.asm

driver2.o: driver2.c mailbox.h qpu.h
	g++ -g -O3 -c -o driver2.o driver2.c $(MBOX_INC)

mailbox.o: mailbox.c mailbox.h
	g++ -g -O3 -c -o mailbox.o mailbox.c $(MBOX_INC)

qpu.o: qpu.c qpu.h
	g++ -g -O3 -c -o qpu.o qpu.c $(MBOX_INC)
