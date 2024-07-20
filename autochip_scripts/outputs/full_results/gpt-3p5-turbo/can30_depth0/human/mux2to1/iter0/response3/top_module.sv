module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// Declare internal wire for output
	wire out;

	// Instantiate the multiplexer
	mux_2to1 mux (
		.a(a),
		.b(b),
		.sel(sel),
		.out(out)
	);

endmodule
module mux_2to1 (
	input a,
	input b,
	input sel,
	output out
);

	// Implement the 2-to-1 multiplexer logic
	assign out = (sel == 0) ? a : b;

endmodule
