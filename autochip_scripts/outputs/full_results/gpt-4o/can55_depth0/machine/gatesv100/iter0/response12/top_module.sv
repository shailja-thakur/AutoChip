module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:0] out_any,
	output [99:0] out_different
);

    wire [99:0] in_shifted;
    assign in_shifted = {in[98:0], in[99]};

    // out_both is the bit-wise AND of in and in_shifted
    assign out_both = in[99:1] & in_shifted[98:0];

    // out_any is the bit-wise OR of in and in_shifted
    assign out_any = in | in_shifted;

    // out_different is the bit-wise XOR of in and in_shifted
    assign out_different = in ^ in_shifted;

endmodule
