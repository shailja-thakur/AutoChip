module top_module (
    input [7:0] in,
    output parity
);

    // Compute even parity bit by XORing all 8 bits of 'in'
    assign parity = ^in;

endmodule
