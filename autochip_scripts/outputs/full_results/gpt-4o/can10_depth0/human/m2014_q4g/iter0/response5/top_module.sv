module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	wire xnor_result;

	// XNOR gate
	assign xnor_result = ~(in1 ^ in2);

	// XOR gate
	assign out = xnor_result ^ in3;

endmodule
