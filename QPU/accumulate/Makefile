MBOX_C = /opt/vc/src/hello_pi/hello_fft/mailbox.c
MBOX_INC = -I/opt/vc/src/hello_pi/hello_fft

driver2: driver2.c
	g++ -g -O3 -o driver2 driver2.c $(MBOX_C) $(MBOX_INC)

helloworld: driver.c
	g++ -g -O3 -o helloworld driver.c $(MBOX_C) $(MBOX_INC)
