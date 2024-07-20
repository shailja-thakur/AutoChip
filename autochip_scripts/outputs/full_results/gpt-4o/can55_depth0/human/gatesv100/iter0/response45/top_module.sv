module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

    // Generate out_both
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : out_both_logic
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate

    // Generate out_any
    generate
        for (i = 1; i <= 99; i = i + 1) begin : out_any_logic
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate

    // Generate out_different
    assign out_different[0] = in[0] ^ in[99];  // Special wrap-around case for the first bit
    generate
        for (i = 1; i < 100; i = i + 1) begin : out_different_logic
            assign out_different[i] = in[i] ^ in[i-1];
        end
    endgenerate

endmodule
