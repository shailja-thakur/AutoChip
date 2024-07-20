module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Create a truth table for the given conditions
module truth_table (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Determine the output out_sop in minimum sum-of-products form
	assign out_sop = (a & ~b & c & d) | (~a & b & c & d) | (a & b & c & ~d);

	// Determine the output out_pos in minimum product-of-sums form
	assign out_pos = (a + 1'b1) & (b + 1'b0) & (c + 1'b1) & (d + 1'b1) | (a + 1'b0) & (b + 1'b1) & (c + 1'b1) & (d + 1'b1) | (a + 1'b1) & (b + 1'b1) & (c + 1'b1) & (d + 1'b0);

endmodule
