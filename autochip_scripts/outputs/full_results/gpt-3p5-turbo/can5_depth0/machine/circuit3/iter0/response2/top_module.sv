module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	
	// Intermediate signals for OR operations
	wire ab_or;
	wire cd_or;
	
	// OR gates for a, b and c, d
	assign ab_or = a | b;
	assign cd_or = c | d;
	
	// AND gate for ab_or and cd_or
	assign q = ab_or & cd_or;

endmodule
