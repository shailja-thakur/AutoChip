module top_module (
    input [7:0] in,
    output parity
);

// Compute the parity bit using XOR of all 8 input bits
assign parity = ^in;

endmodule
