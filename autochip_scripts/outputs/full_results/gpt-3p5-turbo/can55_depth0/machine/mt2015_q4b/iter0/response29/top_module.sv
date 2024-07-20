module top_module(
	input x,
	input y,
	output z);

	// Internal wire to connect the XOR gate output with the negation
	wire xor_output;
	
	// XOR gate to compute the exclusive-or of inputs x and y
	xor_gate xor_inst(
		.x(x),
		.y(y),
		.z(xor_output)
	);
	
	// Inverter module to negate the output of the XOR gate
	inverter inv_inst(
		.x(xor_output),
		.z(z)
	);
	
endmodule
module xor_gate(
	input x,
	input y,
	output z);
	
	// Use the XOR operator to compute the output z
	assign z = x ^ y;
	
endmodule
module inverter(
	input x,
	output z);
	
	// Use the logical negation operator to compute the output z
	assign z = ~x;

endmodule
