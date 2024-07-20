module top_module (
    input [7:0] in,
    output parity
);
    assign parity = ^in; // Using reduction XOR to compute even parity
endmodule
