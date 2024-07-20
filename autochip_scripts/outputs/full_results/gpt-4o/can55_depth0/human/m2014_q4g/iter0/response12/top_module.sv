module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// Intermediate wire for the output of the XNOR gate
	wire xnor_out;

	// Two-input XNOR gate
	assign xnor_out = ~(in1 ^ in2);

	// Two-input XOR gate with one input from XNOR output and the other from in3
	assign out = xnor_out ^ in3;

endmodule
