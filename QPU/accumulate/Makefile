MBOX_C = /opt/vc/src/hello_pi/hello_fft/mailbox.c
MBOX_INC = -I/opt/vc/src/hello_pi/hello_fft

OBJS=driver2.o mailbox.o qpu.o

driver2: $(OBJS)
	g++ -g -O3 -o driver2 $(OBJS)

driver2.o: driver2.c
	g++ -g -O3 -c -o driver2.o driver2.c $(MBOX_INC)

mailbox.o: $(MBOX_C)
	g++ -g -O3 -c -o mailbox.o $(MBOX_C) $(MBOX_INC)

qpu.o: qpu.c
	g++ -g -O3 -c -o qpu.o qpu.c $(MBOX_INC)