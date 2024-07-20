module top_module (
    input [7:0] in,
    output parity
);
    assign parity = ^in; // Compute parity bit by XOR'ing all 8 bits of input
endmodule
