module top_module (
	input a,
	input b,
	input sel,
	output out
);
	// Declare wire to hold the output value
	wire out;

	// Implement the multiplexer logic
	assign out = sel ? b : a;

endmodule
