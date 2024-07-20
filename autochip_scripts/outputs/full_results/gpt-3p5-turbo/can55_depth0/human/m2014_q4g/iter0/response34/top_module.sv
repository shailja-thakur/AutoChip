module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

// XNOR gate to calculate the first input for XOR gate
assign in_xnor = in1 ^ in2;

// XOR gate to calculate the final output
assign out = in_xnor ^ in3;

endmodule
