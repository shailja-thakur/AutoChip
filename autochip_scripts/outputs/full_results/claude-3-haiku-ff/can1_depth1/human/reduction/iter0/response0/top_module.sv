module top_module (
    input [7:0] in,
    output parity
);

// Compute parity bit using XOR of all 8 data bits
assign parity = ^in;

endmodule
