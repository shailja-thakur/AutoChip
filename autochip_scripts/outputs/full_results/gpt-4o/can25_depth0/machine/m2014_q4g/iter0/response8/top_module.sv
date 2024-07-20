module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// Intermediate wire to hold the result of the first XOR operation
	wire xor1_result;

	// Perform the first XOR operation on in1 and in2
	assign xor1_result = in1 ^ in2;

	// Perform the bitwise NOT operation on the result of the first XOR
	wire not_result;
	assign not_result = ~xor1_result;

	// Perform the second XOR operation with in3
	assign out = not_result ^ in3;

endmodule
