module top_module (
	input in1,
	input in2,
	output logic out
);

	// in2 has a bubble, which is equivalent to a NOT gate
	assign out = in1 & ~in2;

endmodule
