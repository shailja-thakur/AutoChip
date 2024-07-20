module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// Create a 2-to-1 multiplexer using conditional operator
	assign out = (sel == 0) ? a : b;

endmodule
