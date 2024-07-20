module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Generating the output out_sop using sum-of-products form
// Determine the output out_sop in minimum sum-of-products form
assign out_sop = (~a & ~b & c) | (~a & b & ~c) | (a & b & ~c) | (c & d);

// Generating the output out_pos using product-of-sums form
// Determine the output out_pos in minimum product-of-sums form
assign out_pos = (a | b | ~c) & (a | b | c) & (a | ~b | c) & (~a | b | c) & (~c | d);

endmodule
