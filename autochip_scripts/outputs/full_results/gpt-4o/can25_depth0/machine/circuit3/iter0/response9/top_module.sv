module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Internal signals for the intermediate OR results
	wire or_ab;
	wire or_cd;

	// Perform bitwise OR on inputs a and b
	assign or_ab = a | b;

	// Perform bitwise OR on inputs c and d
	assign or_cd = c | d;

	// Perform bitwise AND on the intermediate OR results to get the output q
	assign q = or_ab & or_cd;

endmodule
