module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

    // Generate out_both
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : out_both_gen
            assign out_both[i] = in[i+1] & in[i];
        end
    endgenerate
    
    // Generate out_any
    genvar j;
    generate
        for (j = 1; j <= 99; j = j + 1) begin : out_any_gen
            assign out_any[j] = in[j] | in[j-1];
        end
    endgenerate

    // Generate out_different
    genvar k;
    generate
        for (k = 0; k <= 99; k = k + 1) begin : out_different_gen
            if (k == 99) begin
                assign out_different[k] = in[k] ^ in[0];
            end else begin
                assign out_different[k] = in[k] ^ in[k+1];
            end
        end
    endgenerate

endmodule
