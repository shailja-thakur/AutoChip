module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
	// Intermediate wire to store the result of in1 XOR in2
	logic temp;

	assign temp = in1 ^ in2;
	assign out = ~temp ^ in3;

endmodule
