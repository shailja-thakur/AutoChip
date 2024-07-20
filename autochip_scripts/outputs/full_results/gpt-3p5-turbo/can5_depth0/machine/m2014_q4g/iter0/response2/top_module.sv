module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// Calculate the bitwise XOR of in1 and in2
	logic xor_result;
	assign xor_result = in1 ^ in2;
	
	// Calculate the bitwise NOT of xor_result
	logic not_result;
	assign not_result = ~xor_result;
	
	// Calculate the bitwise XOR of not_result and in3
	assign out = not_result ^ in3;

endmodule
