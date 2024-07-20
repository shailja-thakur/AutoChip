module top_module (
	input in1,
	input in2,
	output logic out
);

	// Compute the logical OR of the inputs
	wire or_result;
	assign or_result = in1 | in2;

	// Compute the logical negation of the OR result
	assign out = ~or_result;

endmodule
