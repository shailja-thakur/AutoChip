module top_module (
    input [7:0] in,
    output parity
);

assign parity = ^in;  // The XOR of all bits in 'in' computes the even parity bit

endmodule
