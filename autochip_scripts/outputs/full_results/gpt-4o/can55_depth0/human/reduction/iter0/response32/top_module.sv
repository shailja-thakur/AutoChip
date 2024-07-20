module top_module (
    input [7:0] in,
    output parity
);
    // Even parity is 1 if there is an odd number of 1s in 'in', otherwise 0.
    assign parity = ^in; // XOR all bits to compute even parity

endmodule
