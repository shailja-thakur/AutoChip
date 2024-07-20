module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Intermediate signals
	wire or_ab;
	wire or_cd;

	// OR of a and b
	assign or_ab = a | b;

	// OR of c and d
	assign or_cd = c | d;

	// AND of the two ORs to produce the output q
	assign q = or_ab & or_cd;

endmodule
