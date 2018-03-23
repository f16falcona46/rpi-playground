#reads first uniform into r3 (ignores it), moves ELEMENT_NUMBER into r1
mov r3, ra32

#shifts ELEMENT_NUMBER so it represents index of floats, not bytes
shl r1, ra38, 2
#reads second uniform into r2 (address of inputs)
add r0, ra32, r1
mov r1, 16
shl ra1, r1, 2
mov ra2, r1

#ra0 is accumulator
#ra1 is ptr increment
#ra2 is loop counter increment
#r0 is pointer
#r1 is limit
#r2 is the addend
#r3 is loop counter
mov ra0, 0.0
#read limit from third uniform
sub r1, ra32, 1
mov r3, ra38; mov r2, 0.0
:accumulate_loop
	mov ra56, r0
	fadd.ifnn ra0, ra0, r2
	sub.setf ra39, r1, r3
	add r0, r0, ra1
	brr.anynn -, :accumulate_loop
	add r3, r3, ra2
	ldtmu0
	mov r2, r4

#load vector sums
mov r0, ra0
nop
#sum them
mov r1, r0 >> 8
fadd r0, r0, r1
nop
mov r1, r0 >> 4
fadd r0, r0, r1
nop
mov r1, r0 >> 2
fadd r0, r0, r1
nop
mov r1, r0 >> 1
fadd r0, r0, r1

# Configure the VPM for writing
ldi rb49, 0xa00

#writes to the VPM with r0
mov rb48, r0

## move 16 words (1 vector) back to the host (DMA)
ldi rb49, 0x88010000

## initiate the DMA (the last uniform - ra32 - is the host address to write to))
or rb50, ra32, 0;          nop

# Wait for the DMA to complete
or rb39, rb50, ra39;       nop

# trigger a host interrupt (writing rb38) to stop the program
or rb38, ra39, ra39;       nop

thrend
nop
nop
