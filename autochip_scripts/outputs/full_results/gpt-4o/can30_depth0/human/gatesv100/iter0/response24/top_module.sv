module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

    // (1) Compute out_both: in[99:1] & in[98:0]
    assign out_both = in[99:1] & in[98:0];

    // (2) Compute out_any: in[99:1] | in[98:0]
    assign out_any = in[99:1] | in[98:0];

    // (3) Compute out_different: (in[99:1] != in[0:98]), considering wrap-around
    assign out_different[99] = in[99] != in[0];
    assign out_different[98:0] = in[98:0] != in[99:1];

endmodule
