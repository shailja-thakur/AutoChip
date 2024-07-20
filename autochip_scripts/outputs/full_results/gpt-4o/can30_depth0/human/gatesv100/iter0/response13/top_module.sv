module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);
    // Generate out_both: Each bit should indicate if both the corresponding input bit and its left neighbour are '1'
    generate 
        genvar i;
        for (i = 0; i < 99; i = i + 1) begin : both_loop
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate
    
    // Generate out_any: Each bit should indicate if either the corresponding input bit or its right neighbour are '1'
    generate 
        genvar j;
        for (j = 1; j < 100; j = j + 1) begin : any_loop
            assign out_any[j] = in[j] | in[j-1];
        end
    endgenerate
    
    // Generate out_different: Each bit should indicate if the corresponding input bit is different from its left neighbour
    // Treat the vector as wrapping around, so in[99] -> in[0] for wrapping effect
    generate 
        genvar k;
        for (k = 0; k < 100; k = k + 1) begin : different_loop
            if (k == 99) begin
                assign out_different[k] = in[k] ^ in[0];  // wrap around for in[99]
            end else begin
                assign out_different[k] = in[k] ^ in[k+1];
            end
        end
    endgenerate
endmodule
