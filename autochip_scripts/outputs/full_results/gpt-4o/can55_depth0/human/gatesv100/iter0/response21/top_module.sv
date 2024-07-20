module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);
    // out_both: Check if both the current bit and the bit to the left are 1.
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : out_both_gen
            assign out_both[i] = in[i + 1] & in[i];
        end
    endgenerate
    
    // out_any: Check if either the current bit or the bit to the right are 1.
    generate
        for (i = 1; i < 100; i = i + 1) begin : out_any_gen
            assign out_any[i] = in[i] | in[i - 1];
        end
    endgenerate
    
    // out_different: Check if the current bit is different from the bit to the left.
    generate
        for (i = 0; i < 99; i = i + 1) begin : out_different_gen
            assign out_different[i] = in[i] ^ in[i + 1];
        end
        // Special case for wrapping around, compare in[99] with in[0]
        assign out_different[99] = in[99] ^ in[0];
    endgenerate
endmodule
