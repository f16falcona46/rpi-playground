#reads first uniform into r3 (ignores it), moves ELEMENT_NUMBER into r1
mov r3, ra32

#reads second uniform into r2 (address of inputs)
mov r0, ra32
#shifts ELEMENT_NUMBER so it represents index of floats, not bytes
shl r1, ra38, 2
#adds ELEMENT_NUMBER*4 so that it fetches seperate inputs
add r0, r0, r1
#loads addresses to TMU
mov ra56, r0
ldtmu0
mov r2, r4
mov r1, 10000.0
mov r0, 1000.0
sub.setf ra39, r2, r1
fadd.ifnn r2, r2, r0




#add from 1 to 100
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

# Configure the VPM for writing
ldi rb49, 0xa00

#writes to the VPM with r2
mov rb48, r2

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
