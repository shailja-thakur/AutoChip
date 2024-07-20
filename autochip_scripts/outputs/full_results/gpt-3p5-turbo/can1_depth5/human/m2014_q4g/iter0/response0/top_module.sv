module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// two-input XNOR
	assign xnor_out = in1 ^ in2;

	// two-input XOR
	assign out = xnor_out ^ in3;
	
endmodule
