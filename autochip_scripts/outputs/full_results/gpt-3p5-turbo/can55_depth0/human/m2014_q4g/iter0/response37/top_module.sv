module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// Two-input XNOR
	assign xnored = in1 ^ in2;
	
	// Two-input XOR
	assign out = xnored ^ in3;

endmodule
