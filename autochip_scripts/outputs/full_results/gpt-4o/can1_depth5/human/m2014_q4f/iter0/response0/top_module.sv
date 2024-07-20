module top_module (
	input in1,
	input in2,
	output logic out
);

	// Inverting in2 input and then performing AND operation
	assign out = in1 & ~in2;

endmodule
