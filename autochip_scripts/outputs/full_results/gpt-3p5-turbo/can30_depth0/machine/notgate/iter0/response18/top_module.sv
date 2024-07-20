module top_module(
	input in,
	output out
);

	// Declare internal wire
	wire inv;

	// Assign inverse of input to internal wire
	assign inv = ~in;

	// Assign internal wire to output
	assign out = inv;

endmodule
