module top_module (
	input a,
	input b,
	input c,
	input d,
	output q
);
	
	// Declare intermediate wires
	wire ab_or;
	wire cd_or;

	// Perform bitwise OR operations
	assign ab_or = a | b;
	assign cd_or = c | d;

	// Perform bitwise AND operation on the ORs
	assign q = ab_or & cd_or;

endmodule
