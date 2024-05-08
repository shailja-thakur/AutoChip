module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    // Instantiate four one-digit decade counters
    decade_counter d0 (clk, reset, ena[0], q[0:3]);
    decade_counter d1 (clk, reset, ena[1], q[4:7]);
    decade_counter d2 (clk, reset, ena[2], q[8:11]);
    decade_counter d3 (clk, reset, ena[3], q[12:15]);

    // Connect the enable signals
    assign ena[0] = d1.ena;
    assign ena[1] = d2.ena;
    assign ena[2] = d3.ena;

endmodule