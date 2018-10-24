OBJS=driver2.o mailbox.o qpu.o
LINKS=-ldl

driver2: $(OBJS)
	g++ -g -O3 -o driver2 $(OBJS) $(LINKS)

driver2.o: driver2.c
	g++ -g -O3 -c -o driver2.o driver2.c $(MBOX_INC)

mailbox.o: mailbox.c
	g++ -g -O3 -c -o mailbox.o mailbox.c $(MBOX_INC)

qpu.o: qpu.c
	g++ -g -O3 -c -o qpu.o qpu.c $(MBOX_INC)
