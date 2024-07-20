module top_module (
    input [2:0] in,
    output [1:0] out
);

    // Assign the sum of the three input bits to the two output bits
    assign out = in[2:0] + 1'b0;

endmodule
