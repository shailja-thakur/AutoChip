module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

    // Compute out_both: in[i] AND in[i+1] for i = 98 down to 0
    genvar i;
    generate
        for (i = 0; i <= 98; i = i + 1) begin : gen_out_both
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate

    // Compute out_any: in[i] OR in[i-1] for i = 1 up to 99
    generate
        for (i = 1; i <= 99; i = i + 1) begin : gen_out_any
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate

    // Compute out_different: in[i] XOR in[i+1] for i = 98 down to 0, and in[99] XOR in[0]
    generate
        for (i = 0; i <= 98; i = i + 1) begin : gen_out_different
            assign out_different[i] = in[i] ^ in[i+1];
        end
        assign out_different[99] = in[99] ^ in[0];
    endgenerate

endmodule
