module top_module (
	input in1,
	input in2,
	output logic out
);

assign out = in1 & ~in2; // AND gate with in2 input negated (bubble)

endmodule
