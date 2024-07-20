module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output [99:0] out
);

	// Implementing the multiplexer functionality
	assign out = sel ? b : a;

endmodule
