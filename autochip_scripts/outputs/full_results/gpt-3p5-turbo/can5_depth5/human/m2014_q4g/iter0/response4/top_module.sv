module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// XNOR Gate
	assign in1 = ~(in1 ^ in2);

	// XOR Gate
	assign out = in1 ^ in3;

endmodule
