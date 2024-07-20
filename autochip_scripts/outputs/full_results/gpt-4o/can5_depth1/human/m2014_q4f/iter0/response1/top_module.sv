module top_module (
	input in1,
	input in2,
	output logic out
);

	// Inverting in2 before it goes into the AND gate
	assign out = in1 & ~in2;

endmodule
