module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// XNOR gate
	assign xn_out = ~ (in1 ^ in2);

	// XOR gate
	assign out = xn_out ^ in3;

endmodule
