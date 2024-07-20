module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);

// (1) out_both: Indicate if both the corresponding input bit and its neighbour to the left (higher index) are '1'
assign out_both[2] = (in[3] & in[2]);
assign out_both[1] = (in[2] & in[1]);
assign out_both[0] = (in[1] & in[0]);

// (2) out_any: Indicate if either the corresponding input bit and its neighbour to the right are '1'
assign out_any[3] = (in[3] | in[2]);
assign out_any[2] = (in[2] | in[1]);
assign out_any[1] = (in[1] | in[0]);

// (3) out_different: Indicate if the corresponding input bit is different from its neighbour to the left
assign out_different[3] = (in[3] ^ in[0]); // Treating the vector as wrapping around
assign out_different[2] = (in[2] ^ in[3]);
assign out_different[1] = (in[1] ^ in[2]);
assign out_different[0] = (in[0] ^ in[1]);

endmodule
