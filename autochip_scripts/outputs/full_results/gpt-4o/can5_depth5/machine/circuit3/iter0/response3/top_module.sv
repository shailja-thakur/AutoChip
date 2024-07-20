module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Intermediate signals
	wire or1;
	wire or2;
	
	// Perform bitwise OR on inputs a and b
	assign or1 = a | b;
	
	// Perform bitwise OR on inputs c and d
	assign or2 = c | d;
	
	// Perform bitwise AND on the results of the OR gates
	assign q = or1 & or2;

endmodule
