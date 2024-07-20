module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
	// Calculate intermediate values
	logic temp1;

	// Perform bitwise XOR on in1 and in2
	assign temp1 = in1 ^ in2;
	
	// Perform bitwise NOT on the result
	assign temp1 = ~temp1;
	
	// Perform bitwise XOR with in3 and assign to output
	assign out = temp1 ^ in3;

endmodule
