module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
	// Two-input XNOR
	assign xnor_output = ~(in1 ^ in2);
	
	// Two-input XOR
	assign out = xnor_output ^ in3;

endmodule
