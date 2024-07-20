module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

    // out_both: Each bit indicates if both the bit and the bit to its left are '1'
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : both_block
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate
    
    // out_any: Each bit indicates if either the bit or the bit to its right are '1'
    generate
        for (i = 1; i < 100; i = i + 1) begin : any_block
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate
    
    // out_different: Each bit indicates if the bit is different from its left bit (with wrap-around)
    generate
        for (i = 0; i < 99; i = i + 1) begin : different_block
            assign out_different[i] = in[i] ^ in[i+1];
        end
        assign out_different[99] = in[99] ^ in[0]; // Wrap-around case
    endgenerate

endmodule
