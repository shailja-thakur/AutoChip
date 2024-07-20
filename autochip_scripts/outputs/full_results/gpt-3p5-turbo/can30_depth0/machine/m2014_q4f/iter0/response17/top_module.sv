module top_module (
	input in1,
	input in2,
	output logic out
);
	// Declare intermediate signal
	logic not_in2;

	// Perform logical NOT operation on in2
	assign not_in2 = ~in2;

	// Perform logical AND between in1 and not_in2
	assign out = in1 & not_in2;

endmodule
