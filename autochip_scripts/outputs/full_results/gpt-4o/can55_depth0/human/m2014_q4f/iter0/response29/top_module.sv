module top_module (
	input in1,
	input in2,
	output logic out
);

	assign out = in1 & ~in2; // in2 input to the AND gate has a bubble (NOT gate)

endmodule
