module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// wire between XNOR and XOR
	wire xnor_xor_wire;
	
	// XNOR gate
	assign xnor_xor_wire = ~(in1 ^ in2);
	
	// XOR gate
	assign out = xnor_xor_wire ^ in3;
	
endmodule
