module top_module (
	input in1,
	input in2,
	output logic out
);
	// The in2 input to the AND gate has a bubble, which means it is negated.
	assign out = in1 & ~in2;
endmodule
