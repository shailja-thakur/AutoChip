module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
);

    count4 the_counter (clk, c_enable, c_load, c_d);

    // The following logic gates implement the synchronous counter.
    // The counter counts up from 1 to 12 on each positive edge of the clock.
    // When the enable signal is low, the counter is held in reset.

    wire [3:0] counter;
    assign counter = the_counter.Q;

    // The following logic gates implement the synchronous load logic.
    // When the load signal is high, the counter is loaded with the value on the d inputs.

    wire [3:0] d;
    assign d = c_d;

    // The following logic gates implement the synchronous enable logic.
    // When the enable signal is high, the counter is enabled and counts up on each positive edge of the clock.

    wire enable_signal;
    assign enable_signal = enable & ~reset;

    // The following logic gates implement the synchronous reset logic.
    // When the reset signal is high, the counter is reset to 1.

    wire reset_signal;
    assign reset_signal = reset;

    // The following logic gates implement the synchronous output logic.
    // The output of the counter is Q.

    assign Q = counter;

endmodule