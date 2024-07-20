module top_module (
	input a,
	input b,
	input sel,
	output out
);
	// Multiplexer functionality
	assign out = (sel == 1'b0) ? a : b;
endmodule
