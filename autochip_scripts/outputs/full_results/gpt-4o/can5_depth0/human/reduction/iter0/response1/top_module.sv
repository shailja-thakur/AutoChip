module top_module (
    input [7:0] in,
    output parity
);
    // Compute the parity bit (even parity)
    assign parity = ^in;  // XOR all 8 bits together

endmodule
