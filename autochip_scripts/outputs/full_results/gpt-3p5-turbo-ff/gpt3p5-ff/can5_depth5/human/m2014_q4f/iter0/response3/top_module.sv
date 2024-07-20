module top_module (
	input in1,
	input in2,
	output logic out
);
	// corrected to use logic type for inputs

	assign out = in1 & ~in2; // corrected to use bitwise AND operator (&) and bitwise negation operator (~) for the second input
endmodule
