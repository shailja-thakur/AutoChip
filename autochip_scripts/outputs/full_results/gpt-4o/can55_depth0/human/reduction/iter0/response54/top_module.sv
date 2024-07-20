module top_module (
    input [7:0] in,
    output parity
);
    assign parity = ^in; // XOR all the bits of 'in' to produce the parity bit
endmodule
