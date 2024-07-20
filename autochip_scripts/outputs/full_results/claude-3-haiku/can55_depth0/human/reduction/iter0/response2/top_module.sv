module top_module (
    input [7:0] in,
    output parity
);

// Compute the parity bit using XOR operation on all 8 data bits
assign parity = ^in;

endmodule
