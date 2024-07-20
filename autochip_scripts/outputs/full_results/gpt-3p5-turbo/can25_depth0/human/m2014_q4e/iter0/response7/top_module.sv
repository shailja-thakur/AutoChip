module top_module (
	input in1,
	input in2,
	output logic out
);

	// Declare internal signals
	logic internal_out;

	// Instantiate NOR gate
	nor_gate nor1 (
		.in1(in1),
		.in2(in2),
		.out(internal_out)
	);

	// Assign internal signal to output
	assign out = internal_out;

endmodule
module nor_gate (
	input in1,
	input in2,
	output logic out
);

	// Perform NOR operation
	assign out = ~(in1 | in2);

endmodule
