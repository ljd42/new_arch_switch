# Cortex-M new arch_switch() Results

This repo collects some testing results with the [new arch_switch()](https://github.com/zephyrproject-rtos/zephyr/pull/85248).

# Results:

* [FRDM MCX N947](mcx_n947/mcx_n947.md)
* [NUCLEO F411RE](nucleo_f411re/nucleo_f411re.md)

# Summary: 

The new arch_switch : 
- significantly improves TM_COOPERATIVE: 8-12% compared to the current implementation.
- negatively impacts TM_INTERRUPT: -12%
- 5 out of 8 tests crash

