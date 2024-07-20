module top_module(
	input x,
	input y,
	output z);
	
	// Intermediate wire for XOR of x and y
	wire xor_xy;
	
	// Compute XOR of x and y
	assign xor_xy = x ^ y;
	
	// Compute final output z
	assign z = xor_xy & x;
	
endmodule
