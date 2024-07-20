module top_module(
	input x,
	input y,
	output z);

	// Intermediate wire for XOR operation
	wire xor_result;
	
	// XOR operation between inputs x and y
	assign xor_result = x ^ y;
	
	// AND operation between xor_result and input x
	assign z = xor_result & x;

endmodule
