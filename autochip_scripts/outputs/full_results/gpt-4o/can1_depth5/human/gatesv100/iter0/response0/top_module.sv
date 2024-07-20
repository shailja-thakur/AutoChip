module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Generate out_both: Each bit indicates whether both the corresponding input bit and its neighbour to the left are '1'.
    // out_both[98] should check in[98] and in[99] so we need to shift the input vector left by 1 bit and AND with original vector.
    assign out_both = in[98:0] & in[99:1];

    // Generate out_any: Each bit indicates whether any of the corresponding input bit and its neighbour to the right are '1'.
    // out_any[2] should check in[2] or in[1] so we need to shift the input vector right by 1 bit and OR with original vector.
    assign out_any = in[99:1] | in[98:0];

    // Generate out_different: Each bit indicates whether the corresponding input bit is different from its neighbour to the left.
    // Requires wrap-around behavior.
    // out_different[98] should check if in[98] is different from in[99]; out_different[99] should check if in[99] is different from in[0].
    assign out_different[98:0] = in[98:0] ^ in[99:1];
    assign out_different[99] = in[99] ^ in[0];

endmodule
