module top_module(
	input x,
	input y,
	output z);
	
	assign z = (x ^ y) & x; // z = (x XOR y) AND x

endmodule
