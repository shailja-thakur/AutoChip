module top_module (
	input in1,
	input in2,
	output logic out
);
	// Implement the logic negation of the logical OR of in1 and in2
	assign out = ~(in1 | in2);
endmodule
