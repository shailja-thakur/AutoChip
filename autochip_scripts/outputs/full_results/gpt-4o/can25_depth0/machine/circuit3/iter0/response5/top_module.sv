module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	wire ab_or;
	wire cd_or;

	// OR gates
	assign ab_or = a | b;
	assign cd_or = c | d;

	// AND gate
	assign q = ab_or & cd_or;

endmodule
