module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

	// Intermediate signals
	wire e, f, g, h;

	// Logic gates
	and gate1 (e, a, b);
	or gate2 (f, c, d);
	and gate3 (g, c, d);
	and gate4 (h, a, b, d);

	// Final output
	assign out = e | (f & g) | h;

endmodule
