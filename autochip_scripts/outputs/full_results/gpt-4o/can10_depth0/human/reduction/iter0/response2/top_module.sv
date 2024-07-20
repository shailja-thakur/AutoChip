module top_module (
    input [7:0] in,
    output parity
);

assign parity = ^in; // XOR all bits of 'in' to compute even parity

endmodule
