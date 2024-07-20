module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output [99:0] out
);

	// Implementation of the multiplexer logic
	assign out = sel ? b : a;

endmodule
