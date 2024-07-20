module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// Two input XNOR gate
	assign xnor_out = in1 ^ in2;

	// Two input XOR gate
	assign out = xnor_out ^ in3;

endmodule
