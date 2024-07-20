module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Generate out_both
	assign out_both = in[98:0] & in[99];

	// Generate out_any
	assign out_any = {in[99], in[99:1]} | {1'b0, in[99:2]};

	// Generate out_different
	assign out_different = in ^ {in[99], in[99:1]};

endmodule
