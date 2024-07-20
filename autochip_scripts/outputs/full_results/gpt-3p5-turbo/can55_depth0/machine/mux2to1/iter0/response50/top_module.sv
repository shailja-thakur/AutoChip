module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// assign 'out' to 'a' if sel is 0, else assign 'out' to 'b'
	assign out = (sel == 0) ? a : b;

endmodule
