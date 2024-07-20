module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);
	// Logic for out_both
	assign out_both = in[99:1] & in[98:0];

	// Logic for out_any
	assign out_any = in | in[99];

	// Logic for out_different
	assign out_different = in ^ {in[0], in[99:1]};
endmodule
