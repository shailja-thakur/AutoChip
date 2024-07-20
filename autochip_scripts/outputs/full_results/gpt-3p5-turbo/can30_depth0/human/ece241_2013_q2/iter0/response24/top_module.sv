module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Determining the output out_sop in minimum sum-of-products form
assign out_sop = (~a & ~b & ~c & ~d) | (~a & ~b & ~c & d) | (a & ~b & ~c & ~d);

// Determining the output out_pos in minimum product-of-sums form
assign out_pos = (~a | ~b | ~c | ~d) & (~a | ~b | ~c | d) & (a | ~b | ~c | ~d);

endmodule
