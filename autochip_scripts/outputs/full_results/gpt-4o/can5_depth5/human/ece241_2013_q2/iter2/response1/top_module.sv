module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Generate the minterms for the numbers specified: 2, 7, and 15
	wire m2, m7, m15;
	assign m2 = ~a & ~b & c & ~d;
	assign m7 = ~a & b & c & d;
	assign m15 = a & b & c & d;

	// Generate the don't-care terms for the numbers specified: 3, 8, 11, and 12
	wire dc3, dc8, dc11, dc12;
	assign dc3 = ~a & ~b & c & d;
	assign dc8 = a & ~b & ~c & ~d;
	assign dc11 = a & ~b & c & d;
	assign dc12 = a & b & ~c & ~d;

	// Sum-of-products (SOP) - Include only the essential terms (2, 7, 15)
	assign out_sop = (~a & ~b & c & ~d) |
	                 (~a &  b & c &  d) |
	                 ( a &  b & c &  d);

	// Product-of-sums (POS) - Include only the essential terms
	assign out_pos = (a | b | ~c | d) &
	                 (a | ~b | ~c | ~d) &
	                 (~a | ~b | c | d);

endmodule
