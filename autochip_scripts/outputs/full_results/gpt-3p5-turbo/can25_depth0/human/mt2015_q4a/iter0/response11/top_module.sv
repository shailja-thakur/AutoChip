module top_module(
	input x,
	input y,
	output z);

	// Instantiate xor gate
	xor gate1(x, y, z1);

	// Instantiate and gate
	and gate2(x, z1, z);
	
endmodule
