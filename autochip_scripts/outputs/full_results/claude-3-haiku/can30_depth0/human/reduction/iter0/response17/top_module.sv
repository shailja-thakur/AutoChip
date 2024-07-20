module top_module (
    input [7:0] in,
    output parity
);

// Compute parity bit using XOR
assign parity = ^in;

endmodule
