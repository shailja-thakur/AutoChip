module top_module (
	input in1,
	input in2,
	output logic out
);
	// The output is the negation of the OR of the inputs
	assign out = ~(in1 | in2);
endmodule
