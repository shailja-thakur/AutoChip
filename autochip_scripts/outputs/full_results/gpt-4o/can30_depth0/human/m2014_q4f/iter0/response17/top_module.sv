module top_module (
	input in1,
	input in2,
	output logic out
);

	// in2 input to the AND gate has a bubble, so it is inverted
	assign out = in1 & ~in2;

endmodule
