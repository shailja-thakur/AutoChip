module top_module (
    input [7:0] in,
    output parity
);

    assign parity = ^in; // Use bitwise reduction XOR operator to calculate even parity

endmodule
