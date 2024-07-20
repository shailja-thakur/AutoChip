module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
	
	// Two-input XNOR
	assign in_xnor = in1 ^ in2;
	
	// Two-input XOR
	assign out = in_xnor ^ in3;
	
endmodule
