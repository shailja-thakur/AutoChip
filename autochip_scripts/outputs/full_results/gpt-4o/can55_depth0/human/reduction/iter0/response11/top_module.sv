module top_module (
    input [7:0] in,
    output parity
);

    assign parity = ^in; // XOR all 8 bits of input to generate even parity

endmodule
