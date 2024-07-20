module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output [99:0] out
);

	// Wire to store the selected value
	wire [99:0] selected;

	// Multiplexer implementation
	assign selected = sel ? b : a;
	assign out = selected;

endmodule
