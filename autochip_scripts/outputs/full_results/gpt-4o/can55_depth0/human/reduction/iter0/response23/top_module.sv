module top_module (
    input [7:0] in,
    output parity
);

    // Parity bit is the XOR of all 8 input bits for even parity
    assign parity = ^in;

endmodule
