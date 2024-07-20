module top_module (
    input [7:0] in,
    output parity
);
    assign parity = ^in; // The bitwise XOR of all the bits in 'in'
endmodule
