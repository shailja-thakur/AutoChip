module top_module (
	input in1,
	input in2,
	output logic out
);

	// Perform logical OR on the inputs and then negate the result
	assign out = ~(in1 | in2);

endmodule
