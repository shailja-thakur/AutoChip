module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

    // out_both: Each bit should indicate if both the corresponding input bit and its neighbour to the left are '1'.
    // Since in[99] has no neighbour to the left, we output 99 bits.
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : gen_out_both
            assign out_both[i] = in[i] & in[i + 1];
        end
    endgenerate
    
    // out_any: Each bit should indicate if either the corresponding input bit or its neighbour to the right are '1'.
    // Since in[0] has no neighbour to the right, we output bits from 1 to 99.
    generate
        for (i = 1; i < 100; i = i + 1) begin : gen_out_any
            assign out_any[i] = in[i] | in[i - 1];
        end
    endgenerate
    
    // out_different: Each bit should indicate if the corresponding input bit is different from its neighbour to the left.
    // The vector is treated as wrapping around, so in[99]'s neighbour to the left is in[0].
    generate
        for (i = 0; i < 99; i = i + 1) begin : gen_out_different
            assign out_different[i] = in[i] ^ in[i + 1];
        end
        assign out_different[99] = in[99] ^ in[0];
    endgenerate

endmodule
