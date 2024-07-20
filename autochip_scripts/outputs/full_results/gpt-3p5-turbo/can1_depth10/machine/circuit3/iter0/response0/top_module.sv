module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	// bitwise OR of inputs a and b
	wire ab_or;
	or(ab_or, a, b);
	
	// bitwise OR of inputs c and d
	wire cd_or;
	or(cd_or, c, d);
	
	// bitwise AND of the two ORs
	and(q, ab_or, cd_or);
endmodule
