module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

    // out_both: in[98] & in[99], in[97] & in[98], ..., in[0] & in[1]
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate

    // out_any: in[1] | in[0], in[2] | in[1], ..., in[99] | in[98]
    generate
        for (i = 1; i < 100; i = i + 1) begin
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate

    // out_different: wrapping around 
    generate
        for (i = 0; i < 99; i = i + 1) begin
            assign out_different[i] = in[i] ^ in[i+1];
        end
        // Handle the wrap-around case for in[99] and in[0]
        assign out_different[99] = in[99] ^ in[0];
    endgenerate

endmodule
