module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// Use wire for intermediate signals
	wire tmp;

	// XOR in1 and in2
	assign tmp = in1 ^ in2;

	// NOT the result of XOR
	assign tmp = ~tmp;

	// XOR the NOT result with in3
	assign out = tmp ^ in3;

endmodule
