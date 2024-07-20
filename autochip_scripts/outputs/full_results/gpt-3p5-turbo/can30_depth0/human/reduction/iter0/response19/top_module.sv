module top_module (
    input [7:0] in,
    output parity
);

    wire [7:0] xor_all;

    assign xor_all = ^in;

    assign parity = xor_all;

endmodule
