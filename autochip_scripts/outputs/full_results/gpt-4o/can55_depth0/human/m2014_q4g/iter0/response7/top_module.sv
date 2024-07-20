module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// Intermediate signal to hold the result of the XNOR operation
	logic xnor_out;

	// XNOR gate
	assign xnor_out = ~(in1 ^ in2);

	// XOR gate
	assign out = xnor_out ^ in3;

endmodule
