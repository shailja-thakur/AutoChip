module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Minimum sum-of-products form (SOP)
	assign out_sop = (~a & ~b & c & d) | (a & b & c & d) | (~a & b & c & d);

	// Minimum product-of-sums form (POS)
	assign out_pos = ( b | c |  d) & (a | ~b | ~c) & (a |  ~c | ~d);

endmodule
