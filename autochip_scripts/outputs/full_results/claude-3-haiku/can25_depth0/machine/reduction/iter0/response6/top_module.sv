module top_module (
    input [7:0] in,
    output parity
);

// Assign the output port 'parity' to the bitwise XOR of the 8-bit input port 'in'
assign parity = ^in;

endmodule
