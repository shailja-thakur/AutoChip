module top_module (
    input [7:0] in,
    output parity
);

    assign parity = ^in; // XOR all bits in 'in' array to get the parity bit

endmodule
