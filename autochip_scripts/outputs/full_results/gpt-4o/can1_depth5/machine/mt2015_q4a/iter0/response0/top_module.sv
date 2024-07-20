module top_module(
	input x,
	input y,
	output z);

	// Intermediate wire to store the result of the XOR operation
	wire xor_result;
	
	// XOR operation between x and y
	assign xor_result = x ^ y;
	
	// AND operation between xor_result and x to produce the final output z
	assign z = xor_result & x;

endmodule
