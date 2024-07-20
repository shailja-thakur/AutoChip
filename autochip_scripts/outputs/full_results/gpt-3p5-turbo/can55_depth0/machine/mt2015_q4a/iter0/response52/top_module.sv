module top_module(
	input x,
	input y,
	output z);

	// XOR gate
	wire xor_output;
	xor_gate xor1(.a(x), .b(y), .z(xor_output));
	
	// AND gate
	and_gate and1(.a(xor_output), .b(x), .z(z));
	
endmodule
