module top_module (
    input [7:0] in,
    output parity
);
    assign parity = ^in; // XORing all the bits in the 'in' signal to compute even parity
endmodule
