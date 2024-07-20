module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

    // Generate out_both
    // out_both[i] = in[i] & in[i+1] where 0 <= i <= 98
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin: out_both_gen
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate

    // Generate out_any
    // out_any[i] = in[i-1] | in[i] where 1 <= i <= 99
    generate
        for (i = 1; i < 100; i = i + 1) begin: out_any_gen
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate

    // Generate out_different
    // out_different[i] = in[i] ^ in[(i+1) % 100] where 0 <= i <= 99
    generate
        for (i = 0; i < 99; i = i + 1) begin: out_different_gen
            assign out_different[i] = in[i] ^ in[i+1];
        end
        assign out_different[99] = in[99] ^ in[0]; // handling wrap around for in[99] which neighbors in[0]
    endgenerate

endmodule
