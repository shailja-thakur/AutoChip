module top_module (
	input in1,
	input in2,
	output logic out
);

	// Inverting in2 before passing to AND gate
	assign out = in1 & ~in2;

endmodule
