module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	wire or_ab;
	wire or_cd;

	// Bitwise OR of inputs a and b
	assign or_ab = a | b;

	// Bitwise OR of inputs c and d
	assign or_cd = c | d;

	// Bitwise AND of or_ab and or_cd
	assign q = or_ab & or_cd;

endmodule
