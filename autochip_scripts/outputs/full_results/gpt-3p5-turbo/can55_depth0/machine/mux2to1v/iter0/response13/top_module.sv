module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output [99:0] out
);

	// Wire to select between a and b
	wire [99:0] mux_out;

	// Multiplexer logic
	assign mux_out = sel ? b : a;

	// Output assignment
	assign out = mux_out;

endmodule
