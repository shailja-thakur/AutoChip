module top_module (
    input [7:0] in,
    output parity
);
    assign parity = ^in; // XOR operation over all bits of 'in'
endmodule
