module top_module (
    input [7:0] in,
    output parity
);

    assign parity = ^in;  // Computes the parity by XORing all the input bits

endmodule
