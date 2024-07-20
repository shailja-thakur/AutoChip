module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
	
	// Perform the bitwise XOR operation on in1 and in2
	logic xor_result = in1 ^ in2;
	
	// Perform the bitwise NOT operation on the result of the XOR operation
	logic not_result = ~xor_result;
	
	// Perform the bitwise XOR operation between the NOT result and in3
	assign out = not_result ^ in3;
	
endmodule
