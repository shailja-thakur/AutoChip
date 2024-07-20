module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

// (1) out_both: Each bit of this output vector should indicate whether both the corresponding input bit and its neighbour to the left are '1'.
assign out_both = {in[98:0] & in[99:1]};

// (2) out_any: Each bit of this output vector should indicate whether any of the corresponding input bit and its neighbour to the right are '1'.
assign out_any = {in[99:1] | in[98:0]};

// (3) out_different: Each bit of this output vector should indicate whether the corresponding input bit is different from its neighbour to the left. For this part, treat the vector as wrapping around, so in[99]'s neighbour to the left is in[0].
assign out_different[0] = in[0] ^ in[99];
assign out_different[99:1] = in[99:1] ^ in[98:0];

endmodule
