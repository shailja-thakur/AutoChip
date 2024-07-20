module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// Internal wire to hold the intermediate result of in1 XOR in2
	wire intermediate_result;

	// Perform bitwise XOR on in1 and in2
	assign intermediate_result = in1 ^ in2;

	// Perform bitwise NOT on the intermediate result and then XOR with in3
	assign out = ~intermediate_result ^ in3;

endmodule
