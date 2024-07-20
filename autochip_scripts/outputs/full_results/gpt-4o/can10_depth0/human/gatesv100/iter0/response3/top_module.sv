module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);
    genvar i;

    // out_both: Determines if both in[i] and in[i+1] are 1 for i = 0 to 98
    generate
        for (i = 0; i < 99; i = i + 1) begin: out_both_gen
            if (i == 98) begin
                assign out_both[98] = in[98] & in[99];
            end else begin
                assign out_both[i] = in[i] & in[i + 1];
            end
        end
    endgenerate

    // out_any: Determines if either in[i] or in[i-1] is 1 for i = 1 to 99
    generate
        for (i = 1; i < 100; i = i + 1) begin: out_any_gen
            assign out_any[i] = in[i] | in[i - 1];
        end
    endgenerate

    // out_different: Determines if in[i] is different from in[(i+1)%100]
    generate
        for (i = 0; i < 99; i = i + 1) begin: out_different_gen
            assign out_different[i] = in[i] ^ in[(i + 1) % 100];
        end
        assign out_different[99] = in[99] ^ in[0]; // Wrap-around case
    endgenerate

endmodule
