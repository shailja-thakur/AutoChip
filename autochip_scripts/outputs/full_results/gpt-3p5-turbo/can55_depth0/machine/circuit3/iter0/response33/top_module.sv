module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
	
	// The bitwise OR of a and b
	wire ab_or;
	assign ab_or = a | b;

	// The bitwise OR of c and d
	wire cd_or;
	assign cd_or = c | d;

	// The bitwise AND of ab_or and cd_or
	assign q = ab_or & cd_or;

endmodule
