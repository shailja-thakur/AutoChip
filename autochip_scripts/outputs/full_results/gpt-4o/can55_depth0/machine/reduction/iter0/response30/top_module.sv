module top_module (
    input [7:0] in,
    output parity
);

    assign parity = ^in; // ^ is the bitwise XOR reduction operator in Verilog

endmodule
