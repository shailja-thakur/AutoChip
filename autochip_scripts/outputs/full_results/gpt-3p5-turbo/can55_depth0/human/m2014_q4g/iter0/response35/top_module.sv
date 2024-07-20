module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// Two-input XNOR
	assign net1 = in1 ^ in2;

	// Two-input XOR
	assign out = net1 ^ in3;

endmodule
