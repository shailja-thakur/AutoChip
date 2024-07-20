module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
	// Intermediate wire to hold the result of in1 XOR in2
	wire temp;
	
	// Calculate the intermediate value
	assign temp = in1 ^ in2;
	
	// Calculate the final output
	assign out = (~temp) ^ in3;
	
endmodule
