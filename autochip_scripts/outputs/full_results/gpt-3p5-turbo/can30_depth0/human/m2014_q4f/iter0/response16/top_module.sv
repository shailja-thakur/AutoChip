module top_module (
	input in1,
	input in2,
	output logic out
);

	// Implement the AND gate with bubble
	assign out = in1 & ~in2;

endmodule
