module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);

    // out_both: Each bit i of out_both should indicate if both in[i] and in[i+1] are 1
    assign out_both[0] = in[0] & in[1];
    assign out_both[1] = in[1] & in[2];
    assign out_both[2] = in[2] & in[3];

    // out_any: Each bit i of out_any should indicate if either in[i] or in[i-1] are 1
    assign out_any[3] = in[3] | in[2];
    assign out_any[2] = in[2] | in[1];
    assign out_any[1] = in[1] | in[0];

    // out_different: Each bit i of out_different should indicate if in[i] is different from in[i+1],
    // and treat the vector as wrapping around
    assign out_different[0] = in[0] ^ in[3]; // Wrapping around
    assign out_different[1] = in[1] ^ in[0];
    assign out_different[2] = in[2] ^ in[1];
    assign out_different[3] = in[3] ^ in[2];

endmodule
