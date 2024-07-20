module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// Perform bitwise XOR operation on in1 and in2
	logic xor_result;
	assign xor_result = in1 ^ in2;

	// Perform bitwise NOT operation on xor_result
	logic not_result;
	assign not_result = ~xor_result;

	// Perform bitwise XOR operation on not_result and in3
	assign out = not_result ^ in3;

endmodule
