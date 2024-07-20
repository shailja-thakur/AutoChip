module top_module (
    input [2:0] in,
    output [1:0] out
);

    // Population count algorithm:
    // Count the number of 1's in the 3-bit input vector
    assign out[0] = ^in;
    assign out[1] = (in[2] & in[1]) | (in[2] & in[0]) | (in[1] & in[0]);

endmodule
