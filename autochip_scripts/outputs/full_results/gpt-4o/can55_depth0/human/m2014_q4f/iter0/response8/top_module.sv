module top_module (
	input in1,
	input in2,
	output logic out
);
	// Negate the in2 input before feeding it to the AND gate
	assign out = in1 & ~in2;
endmodule
