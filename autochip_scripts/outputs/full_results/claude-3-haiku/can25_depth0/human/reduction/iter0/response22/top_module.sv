module top_module (
    input [7:0] in,
    output parity
);

// Compute parity using XOR of all input bits
assign parity = ^in;

endmodule
