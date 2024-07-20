module top_module (
    input [7:0] in,
    output parity
);
    assign parity = ^in;  // bitwise XOR of all bits in the input
endmodule
