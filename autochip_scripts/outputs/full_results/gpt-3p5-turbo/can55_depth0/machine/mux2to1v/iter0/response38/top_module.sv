module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output [99:0] out
);

	// Wire to store the output value
	wire [99:0] mux_out;

	// Simple multiplexer
	assign mux_out = sel ? b : a;

	// Assigning the output to mux_out
	assign out = mux_out;

endmodule
