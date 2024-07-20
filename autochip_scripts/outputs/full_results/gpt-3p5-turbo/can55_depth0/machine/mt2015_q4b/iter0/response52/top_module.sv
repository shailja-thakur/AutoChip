module top_module(
	input x,
	input y,
	output z);

	// gate implementation
	assign z = ~(x ^ y);
	
endmodule
