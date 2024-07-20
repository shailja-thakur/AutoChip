module top_module(
	input x,
	input y,
	output z);

	// Intermediate wires
	wire xor_output;
	
	// XOR gate
	xor gate1(.a(x), .b(y), .z(xor_output));
	
	// AND gate
	and gate2(.a(xor_output), .b(x), .z(z));
	
endmodule
