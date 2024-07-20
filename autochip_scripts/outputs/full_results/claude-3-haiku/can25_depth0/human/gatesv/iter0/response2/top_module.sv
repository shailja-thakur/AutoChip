module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);

// (1) out_both: Each bit of this output vector should indicate whether both the corresponding input bit and its neighbour to the left (higher index) are '1'.
assign out_both[2] = (in[3] & in[2]);
assign out_both[1] = (in[2] & in[1]);
assign out_both[0] = (in[1] & in[0]);

// (2) out_any: Each bit of this output vector should indicate whether any of the corresponding input bit and its neighbour to the right are '1'.
assign out_any[3] = (in[3] | in[2]);
assign out_any[2] = (in[2] | in[1]);
assign out_any[1] = (in[1] | in[0]);

// (3) out_different: Each bit of this output vector should indicate whether the corresponding input bit is different from its neighbour to the left. For this part, treat the vector as wrapping around, so in[3]'s neighbour to the left is in[0].
assign out_different[3] = (in[3] ^ in[0]);
assign out_different[2] = (in[2] ^ in[3]);
assign out_different[1] = (in[1] ^ in[2]);
assign out_different[0] = (in[0] ^ in[1]);

endmodule
