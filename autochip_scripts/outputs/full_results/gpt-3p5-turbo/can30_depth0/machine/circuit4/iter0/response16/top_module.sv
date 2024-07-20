module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	
	// Output q is the result of a logical OR operation between b and c
	assign q = b || c;
	
endmodule
