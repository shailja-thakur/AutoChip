module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// Define the architecture of the multiplexer
	assign out = sel ? b : a;

endmodule
