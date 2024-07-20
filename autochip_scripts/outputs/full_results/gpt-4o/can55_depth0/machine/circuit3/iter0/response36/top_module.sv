module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Intermediate signals for the OR operations
	wire or_ab;
	wire or_cd;

	// Perform bitwise OR on inputs a and b
	assign or_ab = a | b;

	// Perform bitwise OR on inputs c and d
	assign or_cd = c | d;

	// Perform bitwise AND on the results of the OR operations to get the final output q
	assign q = or_ab & or_cd;

endmodule
