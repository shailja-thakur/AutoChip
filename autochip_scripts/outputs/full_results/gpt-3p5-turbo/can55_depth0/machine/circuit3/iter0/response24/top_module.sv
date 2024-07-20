module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Implemented the logic gate
	assign q = (a | b) & (c | d);
	
endmodule
