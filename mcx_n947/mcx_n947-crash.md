## Cortex M33 
- **platform:** FRDM MCX N947 
- **test**: 
```
west twister --build-only -p frdm_mcxn947/mcxn947/cpu0 -T ../zephyr/tests/benchmarks/thread_metric
west twister --test-only --device-testing --device-serial /dev/ttyACM3 --device-serial-baud 115200 --west-flash="--skip-rebuild" --west-runner=jlink -p frdm_mcxn947/mcxn947/cpu0 -T ../zephyr/tests/benchmarks/thread_metric --timeout-multiplier 0.33 -v
```

platform: frdm_mcxn947_mcxn947_cpu0

| Test | ref (main) | new arch_switch | Improvement |
|:-----|-----------:|----------------:|:-----------:|
|TM_BASIC|399,384 <br> 399,332 <br> 399,323|399,383 <br> 399,330 <br> 399,322|+0.0%|
|TM_COOPERATIVE|25,427,514 <br> 25,425,811 <br> 25,425,446|28,666,576 <br> 28,664,662 <br> 28,664,250|+12.7%|
|TM_INTERRUPT|9,637,348 <br> 9,636,204 <br> 9,636,206|8,491,747 <br> 8,490,776 <br> 8,490,776|-11.9%|
|TM_INTERRUPT_PREEMPTION|6,114,998 <br> 6,114,082 <br> 6,114,081|0 <br> 0 <br> 0|see 1)|
|TM_MEMORY_ALLOCATION|40,915,183 <br> 40,910,570 <br> 40,910,577|40,915,036 <br> 0 <br> 0|see 2)|
|TM_MESSAGE|21,637,836 <br> 21,635,334 <br> 21,635,338|21,637,762 <br> 0 <br> 0|see 3)|
|TM_PREEMPTIVE|18,295,405 <br> 18,293,139 <br> 18,293,140|19,568,055 <br> 0 <br> 0|see 4)|
|TM_SYNCHRONIZATION|46,881,979 <br> 46,875,761 <br> 46,875,761|46,881,820 <br> 0 <br> 0|see 5)|

1\) error reported:
```
E: ***** USAGE FAULT *****
E:   Illegal use of the EPSR
E: r0/a1:  0x00000001  r1/a2:  0x300001e0  r2/a3:  0x300001e0
E: r3/a4:  0x00000000 r12/ip:  0x00000000 r14/lr:  0x10005f0f
E:  xpsr:  0x60000000
E: Faulting instruction address (r15/pc): 0x00000000
E: >>> ZEPHYR FATAL ERROR 35: Unknown error on CPU 0
E: Current thread: 0x300001e0 (unknown)
E: Halting system
```

2\) error reported:
```
***** USAGE FAULT *****
  Attempt to execute undefined instruction
r0/a1:  0x00000000  r1/a2:  0x00000095  r2/a3:  0x30000945
r3/a4:  0x00000000 r12/ip:  0x30001898 r14/lr:  0x100014d5
 xpsr:  0x41000000
Faulting instruction address (r15/pc): 0x000002ac
```

3\) error reported:
```
***** MPU FAULT *****
  Instruction Access Violation
r0/a1:  0x00000000  r1/a2:  0x00000010  r2/a3:  0x30000928
r3/a4:  0x00000001 r12/ip:  0x300008c8 r14/lr:  0x10004b3f
 xpsr:  0x00000000
Faulting instruction address (r15/pc): 0xfe025578
```

4\) error reported:
```
***** MPU FAULT *****
  Instruction Access Violation
r0/a1:  0x00000000  r1/a2:  0x00000000  r2/a3:  0x00000000
r3/a4:  0x00000000 r12/ip:  0xfe025578 r14/lr:  0xfe025578
 xpsr:  0x00000200
Faulting instruction address (r15/pc): 0xfe025578
```

5\) error reported:
```
***** HARD FAULT *****
  Bus fault on vector table read
r0/a1:  0xfefa125b  r1/a2:  0x00000000  r2/a3:  0x100014c7
r3/a4:  0xfe025578 r12/ip:  0x00000000 r14/lr:  0x00000000
 xpsr:  0x00000000
Faulting instruction address (r15/pc): 0x00000000
```
