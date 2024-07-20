module top_module(
	input x,
	input y,
	output z);
	
	/* combinationally compute the XOR of the inputs */
	assign z = ~(x ^ y);
	
endmodule
