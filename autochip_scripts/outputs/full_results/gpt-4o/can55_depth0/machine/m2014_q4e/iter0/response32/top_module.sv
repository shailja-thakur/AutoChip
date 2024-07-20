module top_module (
	input in1,
	input in2,
	output logic out
);

	assign out = ~(in1 | in2); // Logical negation of the OR of in1 and in2

endmodule
