module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// Intermediate signal
	wire xnor_out;
	
	// XNOR Gate
	assign xnor_out = ~(in1 ^ in2);
	
	// XOR Gate
	assign out = xnor_out ^ in3;
	
endmodule
