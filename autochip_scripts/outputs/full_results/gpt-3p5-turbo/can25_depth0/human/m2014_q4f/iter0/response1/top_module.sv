module top_module (
	input in1,
	input in2,
	output logic out
);

	// Implement AND gate with bubbled input
	assign out = in1 & ~in2;

endmodule
