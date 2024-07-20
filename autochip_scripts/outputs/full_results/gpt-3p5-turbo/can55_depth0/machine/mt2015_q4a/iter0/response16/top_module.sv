module top_module(
	input x,
	input y,
	output z);
	
	// Logic to compute output z
	assign z = (x ^ y) & x;  // Compute XOR of x and y and AND it with x
	
endmodule
