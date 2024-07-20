module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// Two-input XNOR gate
	assign xnor_out = in1 ^ in2; // XNOR gate, the output is the inverse of the XOR gate

	// Two-input XOR gate
	assign out = xnor_out ^ in3; // XOR gate

endmodule
