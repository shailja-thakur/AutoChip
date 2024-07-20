module top_module(
	input a, 
	input b,
	output out
);
	
	// implementation of NOR gate
	// using De Morgan's theorem: NOR = (a AND b) == 0
	
	assign out = ~(a & b);
	
endmodule
