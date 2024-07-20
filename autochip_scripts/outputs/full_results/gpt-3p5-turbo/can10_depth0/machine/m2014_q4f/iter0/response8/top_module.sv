module top_module (
	input in1,
	input in2,
	output logic out
);

	// Perform the logical AND operation
	assign out = in1 & ~in2;

endmodule
