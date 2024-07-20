module top_module (
    input [7:0] in,
    output parity
);
    assign parity = ^in;   // XOR operation on input bits to compute the parity bit
endmodule
