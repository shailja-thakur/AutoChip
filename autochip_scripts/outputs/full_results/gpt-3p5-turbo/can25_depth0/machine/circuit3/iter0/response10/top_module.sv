module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	// OR gates for inputs a and b
	wire ab_or;
	assign ab_or = a | b;
	
	// OR gates for inputs c and d
	wire cd_or;
	assign cd_or = c | d;
	
	// AND gate for ab_or and cd_or
	assign q = ab_or & cd_or;
endmodule
