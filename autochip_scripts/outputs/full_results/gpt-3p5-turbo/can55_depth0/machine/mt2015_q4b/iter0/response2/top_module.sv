module top_module(
	input x,
	input y,
	output z);

	// XOR gate
	wire xor_output;
	xor_gate xor(x, y, xor_output);

	// Inverter
	wire inv_output;
	inverter inv(xor_output, inv_output);

	// Assign output
	assign z = inv_output;

endmodule
