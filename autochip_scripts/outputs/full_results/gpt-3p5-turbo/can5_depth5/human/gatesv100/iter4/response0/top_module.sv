module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Logic for out_both
	assign out_both[98:0] = in[98:0] & in[99:1];

	// Logic for out_any
	assign out_any[99:1] = {in, 1'b0} | in[0];

	// Logic for out_different
	assign out_different[99] = (in[99] != in[0]);
	assign out_different[98:0] = (in[98:0] != in[99:1]);

endmodule
