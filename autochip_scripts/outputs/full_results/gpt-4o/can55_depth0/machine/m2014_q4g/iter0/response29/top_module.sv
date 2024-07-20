module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
	// Intermediate wire to hold the result of the initial XOR operation
	wire intermediate_result;

	// Perform the bitwise XOR operation on in1 and in2
	assign intermediate_result = in1 ^ in2;

	// Perform the bitwise NOT operation on the intermediate result and then XOR with in3
	assign out = (~intermediate_result) ^ in3;

endmodule
