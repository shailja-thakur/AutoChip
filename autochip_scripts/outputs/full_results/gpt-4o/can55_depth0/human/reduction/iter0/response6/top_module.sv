module top_module (
    input [7:0] in,
    output parity
);

    assign parity = ^in;  // XOR all 8 bits to form the parity bit

endmodule
