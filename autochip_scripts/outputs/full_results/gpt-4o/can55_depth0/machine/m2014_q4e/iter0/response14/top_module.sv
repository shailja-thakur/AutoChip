module top_module (
	input in1,
	input in2,
	output logic out
);

	// The output is the logical negation of the logical OR of the inputs
	assign out = ~(in1 | in2);

endmodule
