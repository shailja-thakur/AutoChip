module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Intermediate wires for the OR operations
	wire ab_or;
	wire cd_or;

	// Perform the OR operations
	assign ab_or = a | b;
	assign cd_or = c | d;

	// Perform the AND operation on the results of the OR operations
	assign q = ab_or & cd_or;

endmodule
