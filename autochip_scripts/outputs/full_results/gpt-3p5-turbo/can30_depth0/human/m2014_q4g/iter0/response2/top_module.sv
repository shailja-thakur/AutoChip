module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
	// Implementing two-input XNOR
	assign out_xnor = ~(in1 ^ in2); 

	// Implementing two-input XOR
	assign out = out_xnor ^ in3;
endmodule
