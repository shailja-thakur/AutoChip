module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
    // (1) out_both: Each bit should indicate whether both the corresponding input bit and its neighbour to the left are '1'.
    assign out_both = in[99:1] & in[98:0];
    
    // (2) out_any: Each bit should indicate whether any of the corresponding input bit and its neighbour to the right are '1'.
    assign out_any = in[99:1] | in[98:0];

    // (3) out_different: Each bit should indicate whether the corresponding input bit is different from its neighbour to the left.
    assign out_different[99:1] = in[99:1] ^ in[98:0];
    assign out_different[0] = in[0] ^ in[99];  // Wrapping condition

endmodule
