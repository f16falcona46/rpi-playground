import numpy as np

from videocore.assembler import qpu
from videocore.driver import Driver


@qpu
def accumulate(asm):
    mov(r3, uniform)
    shl(r1, element_number, 2)
    iadd(r0, uniform, r1)
    ldi(r1, 16)
    shl(ra1, r1, 2)
    mov(ra2, r1)

    mov(ra0, 0.0)
    iadd(r1, uniform, 15)
    mov(r3, element_number).mov(r2, 0.0)

    L.accumulate_loop
    mov(tmu0_s, r0)
    isub(null, r1, r3, set_flags=True)
    fadd(ra0, ra0, r2, cond="nc")
    iadd(r0, r0, ra1)
    isub(null, r1, r3, set_flags=True)
    jnc_any(L.accumulate_loop)
    iadd(r3, r3, ra2)
    nop(sig='load tmu0')
    mov(r2, r4)

    mov(r0, ra0)
    nop()
    for r in [8, 4, 2, 1]:
        rotate(r1, r0, r)
        fadd(r0, r0, r1)
        nop()

    setup_vpm_write(mode='32bit horizontal', Y=0, X=0)
    mov(vpm, r0)
    setup_dma_store(mode='32bit horizontal', Y=0, nrows=16)
    start_dma_store(uniform)
    wait_dma_store()

    exit()


with Driver() as drv:
    N = 1024

    # Input vector
    a = ((np.r_[0:N]) * 3 + np.ones(N) * 9999.0).astype('float32')

    # Copy vectors to shared memory for DMA transfer
    inp = drv.copy(a)
    out = drv.alloc(16, 'float32')

    # Run the program
    drv.execute(
        n_threads=1,
        program=drv.program(accumulate),
        uniforms=[1, inp.address, N, out.address]
    )

    cpu_sum = np.sum(a)
    gpu_sum = out[0]
    print("CPU sum:    " + str(cpu_sum))
    print("GPU sum:    " + str(gpu_sum))
    print("Difference: " + str(cpu_sum - gpu_sum))
