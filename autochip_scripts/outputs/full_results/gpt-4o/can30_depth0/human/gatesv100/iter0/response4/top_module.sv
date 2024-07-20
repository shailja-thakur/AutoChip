module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

    // Compute out_both: each bit indicating if both the corresponding input bit and its left neighbour are '1'
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : both_generate
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate

    // Compute out_any: each bit indicating if any of the corresponding input bit and its right neighbour are '1'
    generate
        for (i = 1; i < 100; i = i + 1) begin : any_generate
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate

    // Compute out_different: each bit indicating if the corresponding input bit is different from its left neighbour
    assign out_different[0] = in[0] ^ in[99];  // Treating vector as wrapping around
    generate
        for (i = 1; i < 100; i = i + 1) begin : different_generate
            assign out_different[i] = in[i] ^ in[i-1];
        end
    endgenerate

endmodule
