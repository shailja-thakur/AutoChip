// We want to create a timer with one input that:

// first, is started when a particular input pattern (1101) is detected,
// second, shifts in 4 more bits to determine the duration to delay,
// third, waits for the counters to finish counting, and
// fourth, notifies the user and waits for the user to acknowledge the timer.
// fifth, The serial data is available on the data input pin. When the pattern 1101 is received, the circuit must then shift in the next 4 bits, // most-significant-bit first. These 4 bits determine the duration of the timer delay. I'll refer to this as the delay[3:0].

// After that, the state machine asserts its counting output to indicate it is counting. The state machine must count for exactly (delay[3:0] + 1) * 1000 clock cycles. e.g., delay=0 means count 1000 cycles, and delay=5 means count 6000 cycles. Also output the current remaining time. This should be equal to delay for 1000 cycles, then delay-1 for 1000 cycles, and so on until it is 0 for 1000 cycles. When the circuit isn't counting, the count[3:0] output is don't-care (whatever value is convenient for you to implement).

// At that point, the circuit must assert done to notify the user the timer has timed out, and waits until input ack is 1 before being reset to look for the next occurrence of the start sequence (1101).

// The circuit should reset into a state where it begins searching for the input sequence 1101.

// Hint: It's ok to have all the code in a single module if the components are in their own always blocks, as long as it's clear which blob of code corresponds to which hardware block. Don't merge multiple always blocks together, as that's hard to read and error-prone.

module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );

    // Insert your code here

endmodule
