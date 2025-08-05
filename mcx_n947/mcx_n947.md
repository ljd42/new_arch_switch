## Cortex M33 

Latest Test:
---
- generated on:  2025-08-05 16:43:33 UTC
- platform    : frdm_mcxn947_mcxn947_cpu0
- main version: v4.2.0-965-g96d062add8c5
- switch_arch : v4.2.0-783-g4cbbeb362890

| Test | ref (main) | new arch_switch | Improvement |
|:-----|-----------:|----------------:|:-----------:|
|TM_BASIC|399,384 <br> 399,332 <br> 399,323|399,382 <br> 399,331 <br> 399,321|+0.0%|
|TM_COOPERATIVE|25,427,514 <br> 25,425,811 <br> 25,425,446|28,666,554 <br> 28,664,639 <br> 28,664,227|+12.7%|
|TM_INTERRUPT|9,637,348 <br> 9,636,204 <br> 9,636,206|8,319,076 <br> 8,318,089 <br> 8,318,091|-13.7%|
|TM_INTERRUPT_PREEMPTION|6,114,998 <br> 6,114,082 <br> 6,114,081|5,125,992 <br> 5,125,222 <br> 5,125,223|-16.2%|
|TM_MEMORY_ALLOCATION|40,915,183 <br> 40,910,570 <br> 40,910,577|40,915,004 <br> 40,910,394 <br> 40,910,387|+0.0%|
|TM_MESSAGE|21,637,836 <br> 21,635,334 <br> 21,635,338|21,637,745 <br> 21,635,244 <br> 21,635,242|+0.0%|
|TM_PREEMPTIVE|18,295,405 <br> 18,293,139 <br> 18,293,140|19,432,853 <br> 19,430,447 <br> 19,430,444|+6.2%|
|TM_SYNCHRONIZATION|46,881,979 <br> 46,875,761 <br> 46,875,761|46,881,782 <br> 46,875,556 <br> 46,875,553|+0.0%|

Older Tests from 04 Aug 2025:
---

The current implementation of the new arch_switch has some limitations related
to MPU and FPU support. Using the default settings, the 5/8 tests thread 
metric tests fail. See the [test results](mcx_n947-crash.md) 

The `prj.conf` must be changed as follows:
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

- **platform:** FRDM MCX N947 
- **test**: 
```
west twister --build-only -p frdm_mcxn947/mcxn947/cpu0 -T ../zephyr/tests/benchmarks/thread_metric
west twister --test-only --device-testing --device-serial /dev/ttyACM3 --device-serial-baud 115200 --west-flash="--skip-rebuild" --west-runner=jlink -p frdm_mcxn947/mcxn947/cpu0 -T ../zephyr/tests/benchmarks/thread_metric --timeout-multiplier 0.33 -v
```

platform: frdm_mcxn947_mcxn947_cpu0

| Test | ref (main) | new arch_switch | Improvement |
|:-----|-----------:|----------------:|:-----------:|
|TM_BASIC|399,384 <br> 399,332 <br> 399,323|399,383 <br> 399,330 <br> 399,321|+0.0%|
|TM_COOPERATIVE|22,846,049 <br> 22,844,520 <br> 22,844,522|18,862,747 <br> 18,861,488 <br> 18,861,489|-17.4%|
|TM_INTERRUPT|9,658,021 <br> 9,656,875 <br> 9,656,877|8,428,110 <br> 8,427,110 <br> 8,427,109|-12.7%|
|TM_INTERRUPT_PREEMPTION|5,799,793 <br> 5,798,924 <br> 5,798,923|4,348,415 <br> 4,347,762 <br> 4,347,761|-25.0%|
|TM_MEMORY_ALLOCATION|40,915,185 <br> 40,910,572 <br> 40,910,579|39,479,412 <br> 39,474,962 <br> 39,474,958|-3.5%|
|TM_MESSAGE|21,637,837 <br> 21,635,335 <br> 21,635,333|21,637,756 <br> 21,635,256 <br> 21,635,253|+0.0%|
|TM_PREEMPTIVE|12,144,278 <br> 12,142,772 <br> 12,142,770|12,613,935 <br> 12,612,370 <br> 12,612,370|+3.9%|
|TM_SYNCHRONIZATION|50,007,449 <br> 50,000,839 <br> 50,000,839|50,007,258 <br> 50,000,615 <br> 50,000,613|+0.0%|

