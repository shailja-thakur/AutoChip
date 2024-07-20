module top_module(
	input x,
	input y,
	output z);
	
	// Assignments for z
	assign z = (x & ~y) | (y & ~x);
	
endmodule
