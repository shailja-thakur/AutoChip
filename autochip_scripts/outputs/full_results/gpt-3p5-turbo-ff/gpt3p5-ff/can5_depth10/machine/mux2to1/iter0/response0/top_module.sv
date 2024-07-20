module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// mux implementation
	assign out = sel ? b : a;

endmodule
