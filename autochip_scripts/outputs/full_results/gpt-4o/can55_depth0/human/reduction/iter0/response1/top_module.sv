module top_module (
    input [7:0] in,
    output parity
);

    assign parity = ^in; // XOR reduction operator to generate even parity

endmodule
