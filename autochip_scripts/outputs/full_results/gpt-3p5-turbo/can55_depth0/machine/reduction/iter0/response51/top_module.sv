module top_module (
    input [7:0] in,
    output parity
);
    assign parity = ^in;  // bitwise XOR of the 8-bit input port
endmodule
