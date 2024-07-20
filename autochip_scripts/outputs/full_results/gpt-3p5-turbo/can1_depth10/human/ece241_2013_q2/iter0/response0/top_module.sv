module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Generating the output out_sop using sum-of-products form
assign out_sop = (~a & ~b & ~c & ~d) | (~a & b & ~c & ~d) | (~a & ~b & c & ~d);

// Generating the output out_pos using product-of-sums form
assign out_pos = (a | b | c | d) & (~a | ~b | c | ~d) & (~a | b | ~c | ~d);

endmodule
