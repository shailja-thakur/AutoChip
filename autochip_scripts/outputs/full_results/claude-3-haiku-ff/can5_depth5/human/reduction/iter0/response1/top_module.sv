module top_module (
    input [7:0] in,
    output parity
);

// Use the XOR operation to compute the parity bit
assign parity = ^in;

endmodule
