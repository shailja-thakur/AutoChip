module top_module (
	input in1,
	input in2,
	output logic out
);

	// Logical AND gate
	and gate_AND (
		.in1(in1),
		.in2(~in2),
		.out(out)
	);

endmodule
