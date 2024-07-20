module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Intermediate wires to hold the results of OR operations
	wire or1, or2;
	
	// OR operations
	assign or1 = a | b;
	assign or2 = c | d;
	
	// AND operation for final output
	assign q = or1 & or2;

endmodule
