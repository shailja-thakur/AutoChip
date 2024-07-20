module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
	// Intermediate signal to hold the result of the first XOR and NOT operations
	logic temp;
	
	// Perform the operations
	assign temp = ~(in1 ^ in2);
	assign out = temp ^ in3;
	
endmodule
