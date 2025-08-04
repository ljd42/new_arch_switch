
## Cortex M7
- **platform:** STM32H750B-DK
- **test**:

Put the following patch in `bench_test.patch` and apply it: `git apply bench_test.patch`
```
diff --git a/tests/benchmarks/thread_metric/prj.conf b/tests/benchmarks/thread_metric/prj.conf
index df5648feb87..2d359c8a057 100644
--- a/tests/benchmarks/thread_metric/prj.conf
+++ b/tests/benchmarks/thread_metric/prj.conf
@@ -15,6 +15,8 @@ CONFIG_MP_MAX_NUM_CPUS=1
 
 # Disabling hardware stack protection can greatly
 # improve system performance.
+CONFIG_ARM_MPU=n
+CONFIG_FPU=y
 CONFIG_HW_STACK_PROTECTION=n
 
 # Picolibc is faster than Zephyr's minimal libc memcpy
```

Run test on main
```
west twister --device-testing --device-serial /dev/ttyACM0 --device-serial-baud 115200 -p stm32h750b_dk -T tests/benchmarks/thread_metric --timeout-multiplier 0.33 -v
```

```
gh pr checkout 85248
west update
```

Apply patch and re-run test as above.

Generate report
```
python3 [path_to new_arch_switch]/tm_report.py ./twister-out.1 ./twister-out
```

ref commit: a1f66f05d292ff51c3c6fdc081867bc0a5b232bd

new_switch commit: c39979f5d1c0147221f0caee7f0c800b3ca83b4f

- 1st run

| Test | ref (main) | new arch_switch | Improvement |
|:-----|-----------:|----------------:|:-----------:|
|TM_BASIC|403,310 <br> 403,252 <br> 403,253|447,361 <br> 447,297 <br> 447,297|+10.9%|
|TM_COOPERATIVE|20,328,948 <br> 20,327,557 <br> 20,327,557|20,560,238 <br> 20,558,834 <br> 20,558,835|+1.1%|
|TM_INTERRUPT|6,488,722 <br> 6,487,947 <br> 6,487,947|5,677,129 <br> 5,676,479 <br> 5,676,480|-12.5%|
|TM_INTERRUPT_PREEMPTION|4,416,602 <br> 4,415,953 <br> 4,418,228|3,363,578 <br> 3,363,069 <br> 3,363,069|-23.9%|
|TM_MEMORY_ALLOCATION|37,600,625 <br> 37,596,374 <br> 37,596,397|32,728,667 <br> 32,724,797 <br> 32,724,784|-13.0%|
|TM_MESSAGE|19,526,799 <br> 19,524,536 <br> 19,524,548|20,749,913 <br> 20,747,481 <br> 20,747,476|+6.3%|
|TM_PREEMPTIVE|11,984,640 <br> 11,983,150 <br> 11,983,150|13,452,425 <br> 13,446,602 <br> 13,446,599|+12.2%|
|TM_SYNCHRONIZATION|42,620,982 <br> 42,612,133 <br> 42,613,082|41,620,046 <br> 41,614,265 <br> 41,614,256|-2.3%|

- 2nd run

| Test | ref (main) | new arch_switch | Improvement |
|:-----|-----------:|----------------:|:-----------:|
|TM_BASIC|403,310 <br> 403,252 <br> 403,253|447,361 <br> 447,297 <br> 447,297|+10.9%|
|TM_COOPERATIVE|20,328,948 <br> 20,327,557 <br> 20,327,557|20,560,238 <br> 20,558,834 <br> 20,558,835|+1.1%|
|TM_INTERRUPT|6,488,722 <br> 6,487,947 <br> 6,487,947|5,677,129 <br> 5,676,479 <br> 5,676,480|-12.5%|
|TM_INTERRUPT_PREEMPTION|4,416,602 <br> 4,415,953 <br> 4,418,228|3,363,578 <br> 3,363,069 <br> 3,363,069|-23.9%|
|TM_MEMORY_ALLOCATION|37,600,625 <br> 37,596,374 <br> 37,596,397|32,728,667 <br> 32,724,797 <br> 0|-42.0%|
|TM_MESSAGE|19,526,799 <br> 19,524,536 <br> 19,524,548|20,749,913 <br> 20,747,481 <br> 20,747,476|+6.3%|
|TM_PREEMPTIVE|11,984,640 <br> 11,983,150 <br> 11,983,150|13,452,425 <br> 13,446,602 <br> 13,446,599|+12.2%|
|TM_SYNCHRONIZATION|42,620,982 <br> 42,612,133 <br> 42,613,082|41,620,046 <br> 41,614,265 <br> 41,614,256|-2.3%|

No crash or errors