module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// Intermediate signal to hold the output of the XNOR gate
	wire xnor_out;

	// XNOR gate instance
	assign xnor_out = ~(in1 ^ in2);

	// XOR gate instance
	assign out = xnor_out ^ in3;

endmodule
