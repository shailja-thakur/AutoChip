module top_module (
	input [255:0] in,
	input [7:0] sel,
	output out
);
	// Use indexing to select the appropriate bit from the input vector
	assign out = in[sel];
endmodule
