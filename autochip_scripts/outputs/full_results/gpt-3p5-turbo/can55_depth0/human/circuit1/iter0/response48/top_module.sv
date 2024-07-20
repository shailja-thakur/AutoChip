module top_module (
	input a, 
	input b, 
	output q
);

	// Logic equation:
	// q = (a && ~b) || (~a && b)
	
	assign q = (a & ~b) || (~a & b);
		
endmodule
