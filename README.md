# Cortex-M new arch_switch() Results

This repo collects some testing results with the [new arch_switch()](https://github.com/zephyrproject-rtos/zephyr/pull/85248).

# Testing Howto:

Want to test with your favourite Cortex-M platform?
Check out the [Testing Howto](testing-howto.md)

# Results:

* [FRDM MCX N947](mcx_n947/mcx_n947.md)
* [NUCLEO F411RE](nucleo_f411re/nucleo_f411re.md)
* [STM32H750B-DK](stm32h750b_dk/stm32h750b_dk.md)

# Summary:

The new arch_switch :
- significantly improves TM_COOPERATIVE: 8-12% compared to the current implementation.
- slightly improves TM_PREEMPTIVE: 4-6%
- negatively impacts TM_INTERRUPT: -13%. That's to be expected. Quoting Andy:
  >  That's the trade off, btw: defer work to interrupt time (very few apps spin hard on interrupts, and when they do everyone considers it a design bug) to benefit cooperative switch performance (something almost all apps can get stuck on unless implemented very carefully)
- The TM_INTERRUPT_PREEMPTION offers an interresting case: +11.7% for the
cortex M4, but -16.2% for the M33. I am somewhat baffled by this result
- Other test shows no improvements, which is to be expected I think.

