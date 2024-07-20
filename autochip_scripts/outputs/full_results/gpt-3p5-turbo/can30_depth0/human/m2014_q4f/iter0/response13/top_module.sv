module top_module (
	input in1,
	input in2,
	output logic out
);

	// AND gate with in2 input having a bubble
	assign out = in1 & ~in2;

endmodule
