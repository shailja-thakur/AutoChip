module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);

    // Output vector that checks if both the corresponding input bit and its left neighbour are '1'
    assign out_both[0] = in[0] & in[3];
    assign out_both[1] = in[1] & in[0];
    assign out_both[2] = in[2] & in[1];

    // Output vector that checks if any of the corresponding input bit and its right neighbour are '1'
    assign out_any[1] = in[1] | in[0];
    assign out_any[2] = in[2] | in[1];
    assign out_any[3] = in[3] | in[2];

    // Output vector that checks if the corresponding input bit is different from its left neighbour (treat the vector as wrapping around)
    assign out_different[0] = in[0] != in[3];
    assign out_different[1] = in[1] != in[0];
    assign out_different[2] = in[2] != in[1];
    assign out_different[3] = in[3] != in[2];

endmodule
