
## Cortex M4
- **platform:** nucleo F411RE
- **test**:
```
west twister --build-only -p nucleo_f411re/stm32f411xe -T ../zephyr/tests/benchmarks/thread_metric
west twister --test-only --device-testing --device-serial /dev/ttyACM3 --device-serial-baud 115200 --west-flash="--skip-rebuild" --west-runner=openocd -p nucleo_f411re/stm32f411xe -T ../zephyr/tests/benchmarks/thread_metric --timeout-multiplier 0.33 -v
```
platform: nucleo_f411re_stm32f411xe

| Test | ref (main) | new arch_switch | Improvement |
|:-----|-----------:|----------------:|:-----------:|
|TM_BASIC|234,275 <br> 234,242 <br> 234,242|234,274 <br> 234,241 <br> 234,241|+0.0%|
|TM_COOPERATIVE|14,547,589 <br> 14,546,593 <br> 14,546,594|15,826,418 <br> 15,825,339 <br> 15,825,340|+8.8%|
|TM_INTERRUPT|4,983,359 <br> 4,982,766 <br> 4,982,766|4,390,804 <br> 4,390,280 <br> 4,390,280|-11.9%|
|TM_INTERRUPT_PREEMPTION|2,238,064 <br> 2,237,726 <br> 2,237,726|1,938,341 <br> 1,938,048 <br> 0|see 1)|
|TM_MEMORY_ALLOCATION|22,680,503 <br> 22,677,936 <br> 22,677,935|22,680,399 <br> 0 <br> 0|see 2)|
|TM_MESSAGE|11,744,846 <br> 11,743,485 <br> 11,743,484|11,744,793 <br> 0 <br> 0|see 3)|
|TM_PREEMPTIVE|10,099,621 <br> 10,098,367 <br> 10,098,367|10,543,175 <br> 0 <br> 0|see 4)|
|TM_SYNCHRONIZATION|32,004,716 <br> 32,000,259 <br> 32,000,259|32,004,556 <br> 0 <br> 0|see 5)|

1\) error reported:
```
E: ***** BUS FAULT *****
E:   Instruction bus error
E: r0/a1:  0x00000000  r1/a2:  0xe000ed00  r2/a3:  0x00000008
E: r3/a4:  0x200009a0 r12/ip:  0xbf00e7e0 r14/lr:  0xea40b538
E:  xpsr:  0x01000000
E: Faulting instruction address (r15/pc): 0x079b0300
E: >>> ZEPHYR FATAL ERROR 27: Unknown error on CPU 0
E: Current thread: 0x20000120 (unknown)
E: Halting system
```

2\) error reported:
```
***** MPU FAULT *****
  Instruction Access Violation
r0/a1:  0x200017d8  r1/a2:  0x200007d8  r2/a3:  0x20000858
r3/a4:  0x00000000 r12/ip:  0x00000000 r14/lr:  0x080006fd
 xpsr:  0x61000000
Faulting instruction address (r15/pc): 0xfffffffe
```

3\) error reported:
```
***** USAGE FAULT *****
  Illegal use of the EPSR
r0/a1:  0x00000000  r1/a2:  0x20000808  r2/a3:  0x20000868
r3/a4:  0x00000000 r12/ip:  0x20000a88 r14/lr:  0x08003009
 xpsr:  0x60000000
Faulting instruction address (r15/pc): 0x00000000
```

4\) error reported:
```
***** MPU FAULT *****
  Instruction Access Violation
r0/a1:  0x00000000  r1/a2:  0x00000000  r2/a3:  0x00000000
r3/a4:  0x00000000 r12/ip:  0x0000000a r14/lr:  0x46422020
 xpsr:  0x01000200
Faulting instruction address (r15/pc): 0x41205240
```

5\) error reported:
```
***** USAGE FAULT *****
  Illegal use of the EPSR
r0/a1:  0x200007d8  r1/a2:  0x00000000  r2/a3:  0x00000001
r3/a4:  0x00000001 r12/ip:  0x200007d8 r14/lr:  0x080006d5
 xpsr:  0x20000000
Faulting instruction address (r15/pc): 0x00000000
```
