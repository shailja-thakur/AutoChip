module top_module (
	input in1,
	input in2,
	output logic out
);

	assign out = in1 & ~in2;  // AND gate with a bubble (inversion) on in2 input

endmodule
