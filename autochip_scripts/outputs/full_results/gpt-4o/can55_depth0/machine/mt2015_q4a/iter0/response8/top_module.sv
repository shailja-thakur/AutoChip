module top_module(
	input x,
	input y,
	output z);

	// Intermediate signal to hold XOR of x and y
	wire xor_xy;

	// XOR operation
	assign xor_xy = x ^ y;
	
	// AND operation between the XOR result and the first input x
	assign z = xor_xy & x;

endmodule
