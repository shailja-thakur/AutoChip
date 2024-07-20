module top_module (
    input [7:0] in,
    output parity
);
    assign parity = ^in; // Using bitwise XOR to calculate the parity
endmodule
