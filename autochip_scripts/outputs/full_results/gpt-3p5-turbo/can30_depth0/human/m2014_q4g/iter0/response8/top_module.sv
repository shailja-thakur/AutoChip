module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// XNOR gate
	assign wire xnor_out = ~(in1 ^ in2);

	// XOR gate
	assign out = in3 ^ xnor_out;
endmodule
