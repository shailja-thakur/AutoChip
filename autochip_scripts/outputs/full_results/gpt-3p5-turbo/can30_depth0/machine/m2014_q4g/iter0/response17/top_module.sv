module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// Intermediate wire to store the result of in1 XOR in2
	wire xor_result;
	
	// Perform the XOR operation on in1 and in2
	assign xor_result = in1 ^ in2;
	
	// Perform the bitwise NOT operation on xor_result
	assign xor_not_result = ~xor_result;
	
	// Perform the XOR operation on xor_not_result and in3
	assign out = xor_not_result ^ in3;
	
endmodule
