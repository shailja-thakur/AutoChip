module top_module(
	input x,
	input y,
	output z);

	// Internal wires
	wire xor_output;
	
	// XOR gate
	xor_gate xor1(
		.x(x),
		.y(y),
		.z(xor_output)
	);
	
	// NOT gate
	not_gate not1(
		.a(xor_output),
		.y(z)
	);
	
endmodule
module xor_gate(
	input x,
	input y,
	output z);
	
	assign z = x ^ y;
	
endmodule
module not_gate(
	input a,
	output y);
	
	assign y = ~a;
	
endmodule
