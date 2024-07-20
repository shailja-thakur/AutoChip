module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	// Bitwise OR between inputs a and b
	wire ab_or = a | b;

	// Bitwise OR between inputs c and d
	wire cd_or = c | d;

	// Bitwise AND between ab_or and cd_or
	assign q = ab_or & cd_or;
endmodule
