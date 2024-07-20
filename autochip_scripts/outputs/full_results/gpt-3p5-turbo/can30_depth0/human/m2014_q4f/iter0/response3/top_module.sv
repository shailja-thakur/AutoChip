module top_module (
	input in1,
	input in2,
	output logic out
);

	// Connect in2 to a buffer
	buffer #(1) buffer1 (
		.in(in2),
		.out(buffered_in2)
	);

	// Implement an AND gate
	and #(2) and_gate (
		.in1(in1),
		.in2(buffered_in2),
		.out(out)
	);

endmodule
