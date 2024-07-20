module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

    // Generate out_both: Each bit of this output vector should indicate whether both
    // the corresponding input bit and its neighbour to the left are '1'
    // For example, out_both[98] should be in[98] & in[99]
    // out_both[99] is not used
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : generate_out_both
            assign out_both[i] = in[i] & in[i + 1];
        end
    endgenerate

    // Generate out_any: Each bit of this output vector should indicate whether any of the
    // corresponding input bit and its neighbour to the right are '1'
    // For example, out_any[2] should be in[2] | in[1]
    // out_any[0] is not used
    generate
        for (i = 1; i < 100; i = i + 1) begin : generate_out_any
            assign out_any[i] = in[i] | in[i - 1];
        end
    endgenerate

    // Generate out_different: Each bit of this output vector should indicate whether the
    // corresponding input bit is different from its neighbour to the left
    // For example, out_different[98] should be in[98] ^ in[99]
    // Treat the vector as wrapping around, so in[99]'s neighbor to the left is in[0]
    assign out_different[0] = in[0] ^ in[99];
    generate
        for (i = 1; i < 100; i = i + 1) begin : generate_out_different
            assign out_different[i] = in[i] ^ in[i - 1];
        end
    endgenerate

endmodule
