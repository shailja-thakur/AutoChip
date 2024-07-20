module top_module(
	input x,
	input y,
	output z);

	// Declare internal wires
	wire xor_output;
	wire and_output;

	// Perform XOR operation
	xor #(
		.XOR_GATE_DELAY(1)  // Customize delay
	) xor_inst (
		.a(x),
		.b(y),
		.z(xor_output)
	);

	// Perform AND operation
	and #(
		.AND_GATE_DELAY(1)  // Customize delay
	) and_inst (
		.a(xor_output),
		.b(x),
		.z(and_output)
	);

	// Output z
	assign z = and_output;
	
endmodule
