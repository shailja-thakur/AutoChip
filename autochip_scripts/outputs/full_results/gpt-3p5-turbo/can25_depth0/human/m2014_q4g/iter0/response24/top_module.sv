module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
	
	// XNOR gate implementation
	generate
		if (1) begin : xnor
			assign xnor_out = ~(in1 ^ in2);
		end
	endgenerate
	
	// XOR gate implementation
	generate
		if (1) begin : xor
			assign out = in3 ^ xnor_out;
		end
	endgenerate
	
endmodule
