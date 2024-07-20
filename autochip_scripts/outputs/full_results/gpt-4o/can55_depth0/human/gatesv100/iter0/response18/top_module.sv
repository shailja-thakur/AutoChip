module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

    // Generate out_both: out_both[i] = in[i] & in[i+1] for i from 0 to 98
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : generate_out_both
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate

    // Generate out_any: out_any[i] = in[i] | in[i-1] for i from 1 to 99
    generate
        for (i = 1; i < 100; i = i + 1) begin : generate_out_any
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate

    // Generate out_different taking wrap-around into account
    // out_different[i] = in[i] ^ in[(i+1) % 100] for i from 0 to 99
    assign out_different[0] = in[0] ^ in[99];
    generate
        for (i = 1; i < 100; i = i + 1) begin : generate_out_different
            assign out_different[i] = in[i] ^ in[i-1];
        end
    endgenerate

endmodule
