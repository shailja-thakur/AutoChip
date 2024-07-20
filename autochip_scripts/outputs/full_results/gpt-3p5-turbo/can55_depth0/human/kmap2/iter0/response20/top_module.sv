module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	// internal signals
	wire w1, w2, w3, w4;

	// gate-level implementation
	and gate1 (w1, a, !c);
	and gate2 (w2, b, !d);
	and gate3 (w3, !a, c, d);
	and gate4 (w4, a, b, !d);

	or gate5 (out, w1, w2, w3, w4);

endmodule
