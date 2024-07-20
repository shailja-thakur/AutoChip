module top_module (
	input in1,
	input in2,
	output logic out
);
	// Invert in2 and then perform the AND operation
	assign out = in1 & ~in2;
endmodule
