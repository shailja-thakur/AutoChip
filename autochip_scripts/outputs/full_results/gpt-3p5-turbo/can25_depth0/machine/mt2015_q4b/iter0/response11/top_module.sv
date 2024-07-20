module top_module(
	input x,
	input y,
	output z);

	// internal wire declaration
	wire xor_output;

	// instantiate xor gate
	xor_gate xor_inst(
		.x(x),
		.y(y),
		.z(xor_output)
	);

	// instantiate inverter
	inverter inv_inst(
		.x(xor_output),
		.z(z)
	);

endmodule
module xor_gate(
	input x,
	input y,
	output z);
	
	assign z = x ^ y;

endmodule
module inverter(
	input x,
	output z);

	assign z = ~x;

endmodule
