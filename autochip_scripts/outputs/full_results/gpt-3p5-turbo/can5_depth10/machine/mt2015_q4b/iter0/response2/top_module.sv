module top_module(
	input x,
	input y,
	output z);
	
	// Logic gate equations
	assign z = ~(x ^ y);

endmodule
