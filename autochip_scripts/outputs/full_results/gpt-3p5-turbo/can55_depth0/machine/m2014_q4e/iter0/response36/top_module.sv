module top_module (
	input in1,
	input in2,
	output logic out
);

	// Use a wire to hold the logical OR of the two input signals
	wire or_out;
	assign or_out = in1 | in2;

	// Use a wire to hold the logical negation of the logical OR
	wire not_out;
	assign not_out = ~or_out;

	// Assign the output signal
	assign out = not_out;

endmodule
