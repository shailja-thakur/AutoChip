module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Intermediate signals for OR operations
	wire ab_or, cd_or;

	// Perform OR operations
	assign ab_or = a | b;
	assign cd_or = c | d;

	// Perform AND operation for the final output
	assign q = ab_or & cd_or;

endmodule
