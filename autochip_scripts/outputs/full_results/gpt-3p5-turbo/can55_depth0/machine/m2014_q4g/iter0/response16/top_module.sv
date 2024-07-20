module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// Assign the output using the specified formula
	assign out = ~(in1 ^ in2) ^ in3;

endmodule
