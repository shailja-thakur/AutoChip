module top_module (
	input a,
	input b,
	input sel,
	output out
);
	// Output assignment based on the selector input
	assign out = (sel == 1'b1) ? b : a;
endmodule
