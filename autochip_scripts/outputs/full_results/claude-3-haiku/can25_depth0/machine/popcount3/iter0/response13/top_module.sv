module top_module (
    input [2:0] in,
    output [1:0] out
);

    // Calculate the sum of the three input bits
    assign out = in[2:0];

endmodule
