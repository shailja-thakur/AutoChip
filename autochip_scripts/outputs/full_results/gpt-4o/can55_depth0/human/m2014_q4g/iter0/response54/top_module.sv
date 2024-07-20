module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

    logic xnor_out;

	// Implementing the two-input XNOR
	assign xnor_out = ~(in1 ^ in2);
	
	// Implementing the two-input XOR with one input from the XNOR output and the other as 'in3'
	assign out = xnor_out ^ in3;

endmodule
