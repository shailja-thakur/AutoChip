module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	
	// OR gates
	wire ab_or, cd_or;
	assign ab_or = a | b;
	assign cd_or = c | d;
	
	// AND gate
	assign q = ab_or & cd_or;

endmodule
