module top_module (
	input in1,
	input in2,
	output logic out
);

	// Corrected version of the circuit
	assign out = in1 & ~in2;

endmodule
