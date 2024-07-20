module top_module(
	input x,
	input y,
	output z);
	
	// Intermediate wire to hold XOR result
	wire xor_result;
	
	// Logic operation
	assign xor_result = x ^ y; // Exclusive OR (XOR) operation
	assign z = xor_result & x; // AND operation between XOR result and x
	
endmodule
