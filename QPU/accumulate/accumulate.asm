mov r0, 0
mov r1, 1.0
mov r2, 99
mov r3, 0.0
:loop
	add r0, r0, 1
	sub.setf ra39, r2, r0
	brr.allnn -, :loop
	fadd r3, r3, r1
	fadd r1, r1, 1.0
	nop
#ftoi ra0, r3
mov ra0, r3

#load element numbers into r0
mov r0, ra38
#clear r2
mov r2, 0
#sum them
add r2, r2, r0
mov r1, r0 << 1
add r2, r2, r1
mov r0, r1 << 1
add r2, r2, r0
mov r1, r0 << 1
add r2, r2, r1
mov r0, r1 << 1
add r2, r2, r0
mov r1, r0 << 1
add r2, r2, r1
mov r0, r1 << 1
add r2, r2, r0
mov r1, r0 << 1
add r2, r2, r1
mov r0, r1 << 1
add r2, r2, r0
mov r1, r0 << 1
add r2, r2, r1
mov r0, r1 << 1
add r2, r2, r0
mov r1, r0 << 1
add r2, r2, r1
mov r0, r1 << 1
add r2, r2, r0
mov r1, r0 << 1
add r2, r2, r1
mov r0, r1 << 1
add r2, r2, r0
mov r1, r0 << 1
add r2, r2, r1
mov r0, r1 << 1

#SKIPS THOSE ROTATES!!!!
mov r2, ra0

# Configure the VPM for writing
ldi rb49, 0xa00

mov r3, rb32
# Add the input value (first uniform - rb32) and the register with the hard-coded
# constant into the VPM.
#add rb48, ra1, rb32;       nop
mov rb48, r2

## move 16 words (1 vector) back to the host (DMA)
ldi rb49, 0x88010000

## initiate the DMA (the next uniform - ra32 - is the host address to write to))
or rb50, ra32, 0;          nop

# Wait for the DMA to complete
or rb39, rb50, ra39;       nop

# trigger a host interrupt (writing rb38) to stop the program
or rb38, ra39, ra39;       nop

thrend
nop
nop
