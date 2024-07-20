module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Intermediate wires to hold the OR results
	wire or_ab;
	wire or_cd;
	
	// Perform bitwise OR operations
	assign or_ab = a | b;
	assign or_cd = c | d;
	
	// Perform bitwise AND operation for the final output
	assign q = or_ab & or_cd;

endmodule
