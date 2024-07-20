module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// two-input XNOR
	wire xnor_out;
	assign xnor_out = ~(in1 ^ in2); // Negate XNOR output

	// two-input XOR
	assign out = (xnor_out ^ in3); // Corrected XOR output
	
endmodule
