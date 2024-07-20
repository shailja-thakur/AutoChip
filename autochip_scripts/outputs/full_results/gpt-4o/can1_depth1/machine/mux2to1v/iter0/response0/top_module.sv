module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output [99:0] out
);

	// Assign output based on the value of sel
	assign out = sel ? b : a;

endmodule
