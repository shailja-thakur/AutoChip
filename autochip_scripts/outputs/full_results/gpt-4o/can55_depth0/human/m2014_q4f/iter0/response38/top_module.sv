module top_module (
	input in1,
	input in2,
	output logic out
);

	// The bubble on in2 implies a NOT gate before it goes to the AND gate
	assign out = in1 & ~in2;

endmodule
