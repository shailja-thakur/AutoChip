module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);
    // Compute out_both
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : out_both_gen
            assign out_both[i] = in[i] & in[i + 1]; // in[98] & in[99], in[97] & in[98], ...
        end
    endgenerate

    // Compute out_any
    generate
        for (i = 1; i < 100; i = i + 1) begin : out_any_gen
            assign out_any[i] = in[i] | in[i - 1]; // in[1] | in[0], in[2] | in[1], ...
        end
    endgenerate

    // Compute out_different
    assign out_different[0] = in[0] ^ in[99]; // Wrapping around for in[0]
    generate
        for (i = 1; i < 100; i = i + 1) begin : out_different_gen
            assign out_different[i] = in[i] ^ in[i - 1]; // in[1] ^ in[0], in[2] ^ in[1], ...
        end
    endgenerate
endmodule
