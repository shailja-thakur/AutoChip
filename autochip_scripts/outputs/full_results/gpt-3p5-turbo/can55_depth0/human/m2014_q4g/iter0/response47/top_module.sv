module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// Two-input XNOR gate
	assign out_xnor = ~(in1 ^ in2);
	
	// Two-input XOR gate
	assign out_xor = in3 ^ out_xnor;
	
	// Output
	assign out = out_xor;
	
endmodule
