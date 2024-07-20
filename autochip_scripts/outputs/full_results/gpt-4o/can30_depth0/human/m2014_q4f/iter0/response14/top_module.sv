module top_module (
	input in1,
	input in2,
	output logic out
);
	// Inverting in2 input (bubble) and ANDing with in1
	assign out = in1 & ~in2;
endmodule
