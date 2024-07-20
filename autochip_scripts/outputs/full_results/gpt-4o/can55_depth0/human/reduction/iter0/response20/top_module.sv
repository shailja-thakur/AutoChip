module top_module (
    input [7:0] in,
    output parity
);
    assign parity = ^in; // The XOR operator (^) will XOR all bits in the vector

endmodule
