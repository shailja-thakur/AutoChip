module top_module (
	input [255:0] in,
	input [7:0] sel,
	output out
);

	// Use the select vector to index into the input vector
	assign out = in[sel];

endmodule
