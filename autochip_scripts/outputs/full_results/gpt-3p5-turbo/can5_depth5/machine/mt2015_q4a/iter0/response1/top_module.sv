module top_module(
	input x,
	input y,
	output z);
	
	// Logic gates
	wire xor_out;
	wire and_out;
	
	// XOR gate
	xor_gate xor1(
		.x(x),
		.y(y),
		.out(xor_out)
	);
	
	// AND gate
	and_gate and1(
		.x(xor_out),
		.y(x),
		.out(and_out)
	);
	
	// Output
	assign z = and_out;
	
endmodule
