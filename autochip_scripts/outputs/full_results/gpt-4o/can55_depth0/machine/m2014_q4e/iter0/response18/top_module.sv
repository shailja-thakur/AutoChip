module top_module (
	input in1,
	input in2,
	output logic out
);

	// Perform the logical OR operation on the two inputs, then negate the result
	assign out = ~(in1 | in2);

endmodule
