module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Logic for OR gate between a and b
	wire ab_or;
	assign ab_or = a | b;
	
	// Logic for OR gate between c and d
	wire cd_or;
	assign cd_or = c | d;
	
	// Logic for AND gate between ab_or and cd_or
	assign q = ab_or & cd_or;

endmodule
