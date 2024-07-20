module top_module(
	input x,
	input y,
	output z);

	// Intermediate signal to hold the XOR result
	wire xor_result;
	
	// XOR operation between the two inputs
	assign xor_result = x ^ y;
	
	// AND operation between the XOR result and input x
	assign z = xor_result & x;

endmodule
