// We want to create a timer that:

// First, is started when a particular pattern (1101) is detected,
// Second, shifts in 4 more bits to determine the duration to delay,
// Third, waits for the counters to finish counting, and
// Fourth, notifies the user and waits for the user to acknowledge the timer.
// Fifth, In this problem, implement just the finite-state machine that controls the timer. The data path (counters and some comparators) are not included here.

// The serial data is available on the data input pin. When the pattern 1101 is received, the state machine must then assert output shift_ena for exactly 4 clock cycles.

// After that, the state machine asserts its counting output to indicate it is waiting for the counters, and waits until input done_counting is high.

// At that point, the state machine must assert done to notify the user the timer has timed out, and waits until input ack is 1 before being reset to look for the next occurrence of the start sequence (1101).

// The state machine should reset into a state where it begins searching for the input sequence 1101.

module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );

    // Insert your code here

endmodule
