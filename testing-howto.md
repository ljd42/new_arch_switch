# How to test 

- Run test on main.
```
west twister --device-testing --device-serial /dev/ttyACM0 --device-serial-baud 115200 -p stm32h750b_dk -T tests/benchmarks/thread_metric --timeout-multiplier 0.33 -v
```
Have a nice break now... The compilation takes 1-5 minutes (depending on your build machine). The benchmark alone **takes ~12 minutes** to run
(8 tests, each 90 seconds).

- Run test on [PR 85248](https://github.com/zephyrproject-rtos/zephyr/pull/85248)
```
gh pr checkout 85248
west update
west twister --device-testing [...] (as before)
```
Have another nice break...

**Important**: The TM_BASIC benchmark asserts that we're testing under the
same condition (= compare apples with apples).
The result should be the same: improvement +0.0%, each row should have the
same value ∓ 2.

