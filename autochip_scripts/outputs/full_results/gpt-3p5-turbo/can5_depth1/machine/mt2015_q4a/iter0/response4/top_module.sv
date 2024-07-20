module top_module(
	input x,
	input y,
	output z);

	// Declare internal wires
	wire xor_result;
	wire and_result;
	
	// XOR gate
	xor_gate xor1 (
		.a(x),
		.b(y),
		.out(xor_result)
	);

	// AND gate
	and_gate and1 (
		.a(xor_result),
		.b(x),
		.out(and_result)
	);
	
	// Output
	assign z = and_result;
	
endmodule
