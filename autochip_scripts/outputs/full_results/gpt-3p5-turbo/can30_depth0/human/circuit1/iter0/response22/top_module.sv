module top_module (
	input a, 
	input b, 
	output q
);

	// Implement the truth table
	assign q = (a & ~b) | (~a & b);

endmodule
